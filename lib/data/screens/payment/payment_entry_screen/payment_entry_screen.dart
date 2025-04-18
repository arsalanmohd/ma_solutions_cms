import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/database/rentals/rental_db.dart';
import 'package:ma_solutions_cms/data/models/payment/payment_model.dart';

import '../../../database/payment/payment_db.dart';
import '../../../models/rentals/rental_model.dart';

class PaymentEntryScreen extends StatefulWidget {
  @override
  _PaymentEntryScreenState createState() => _PaymentEntryScreenState();
}

class _PaymentEntryScreenState extends State<PaymentEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedRentalId;
  final TextEditingController _amountPaidController = TextEditingController();
  DateTime _paymentDate = DateTime.now();
  String _selectedPaymentMode = 'Cash';

  List<Map<String, dynamic>> _rentals = [];

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    List<Rental> rentalList = await RentalDB.getALLRentals();

    // Convert to list
    _rentals = rentalList.map((rental) => {
      'id': rental.id,  // Ensure rental.id is an integer
      'name': rental.customerId.toString(), // Convert customerId to a String for display
    }).toList();

    setState(() {});
  }

  Future<void> _savePayment() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedRentalId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a rental')),
        );
        return;
      }

      Payment newPayment = Payment(
        rentalId: _selectedRentalId!.toString(),
        amountPaid: double.parse(_amountPaidController.text),
        paymentDate: _paymentDate.toIso8601String(),
        paymentMode: _selectedPaymentMode,
      );
      await PaymentDB.insertPayment(newPayment);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Payment')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<int>(
                value: _selectedRentalId,
                hint: Text("Select Rental"),
                items: _rentals.map((rental) {
                  return DropdownMenuItem<int>(
                    value: rental['id'],  // Use rental instead of undefined variable
                    child: Text(rental['name'].toString()), // Ensure name is a string
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRentalId = value;
                  });
                },
                decoration: InputDecoration(labelText: 'Rental'),
                validator: (value) => value == null ? 'Please select a rental' : null,
              ),
              TextFormField(
                controller: _amountPaidController,
                decoration: InputDecoration(labelText: 'Amount Paid'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter amount' : null,
              ),
              DropdownButtonFormField(
                value: _selectedPaymentMode,
                items: ['Cash', 'UPI'].map((mode) {
                  return DropdownMenuItem(value: mode, child: Text(mode));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPaymentMode = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Payment Mode'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _savePayment,
                child: Text('Save Payment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
