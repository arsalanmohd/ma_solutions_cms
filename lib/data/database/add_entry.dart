import 'package:flutter/material.dart';
import '../models/dashboard_model.dart';
import 'db_helper.dart';

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _occupation = 'Electrician';
  final PaymentStatus _paymentStatus = PaymentStatus.paid;
  final ReceiveStatus _receiveStatus = ReceiveStatus.received;
  DateTime selectedDate = DateTime.now();

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      Dashboard newDashboard = Dashboard(
        dCustomerName: _nameController.text,
        dProductName: _productController.text,
        dCustomerNumber: _numberController.text,
        dOccupation: _occupation,
        date: "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}",
        dPrice: int.parse(_priceController.text),
        pStatus: _paymentStatus,
        rStatus: _receiveStatus,
      );

      await DBHelper.insertDashboard(newDashboard);
      Navigator.pop(context, true); // Return success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Entry")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(controller: _nameController, decoration: InputDecoration(labelText: "Customer Name")),
                TextFormField(controller: _productController, decoration: InputDecoration(labelText: "Product Name")),
                TextFormField(controller: _numberController, decoration: InputDecoration(labelText: "Phone Number")),
                TextFormField(controller: _priceController, decoration: InputDecoration(labelText: "Price"), keyboardType: TextInputType.number),
                DropdownButtonFormField(
                  value: _occupation,
                  items: ['Electrician', 'General', 'Plumber', 'Construction'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (value) => setState(() => _occupation = value as String),
                ),
                ElevatedButton(onPressed: _saveData, child: Text("Save Entry")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
