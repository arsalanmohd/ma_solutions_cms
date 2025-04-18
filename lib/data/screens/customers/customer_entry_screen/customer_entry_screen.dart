import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/customers/customer_model.dart';
import 'package:ma_solutions_cms/data/database/customers/customer_db.dart';

class CustomerEntryScreen extends StatefulWidget {
  @override
  _CustomerEntryScreenState createState() => _CustomerEntryScreenState();
}

class _CustomerEntryScreenState extends State<CustomerEntryScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _addressController = TextEditingController();
  String _occupation = 'Plumber';
  String _statusPaid = 'Due';
  String _statusReturned = 'Not Returned';

  void _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      final customer = Customer(
          name: _nameController.text,
          contact: _contactController.text,
          address: _addressController.text,
          occupation: _occupation,
          statusPaid: _statusPaid,
          statusReturned: _statusReturned
      );
      await CustomerDB.insertCustomer(customer);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Entry'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) => value!.isEmpty ? 'Enter Customer Name' : null,
              ),

              const SizedBox(height: 10.0),

              TextFormField(
                controller: _contactController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) => value!.isEmpty ? 'Enter Phone number' : null,
              ),

              const SizedBox(height: 10.0),

              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Customer Address'),
                validator: (value) => value!.isEmpty ? 'Enter Customer Address' : null,
              ),

              const SizedBox(height: 10.0),

              DropdownButtonFormField(
                value: _occupation,
                items: ['Plumber', 'Construction', 'Electrician', 'General'].map((occupation) {
                  return DropdownMenuItem(
                    value: occupation,
                    child: Text(occupation),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _occupation = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Occupation'),
              ),

              const SizedBox(height: 10.0),

              DropdownButtonFormField(
                value: _statusPaid,
                items: ['Due', 'All Clear'].map((statusPaid) {
                  return DropdownMenuItem(
                    value: statusPaid,
                    child: Text(statusPaid),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _statusPaid = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Payment Status'),
              ),

              const SizedBox(height: 10.0),

              DropdownButtonFormField(
                value: _statusReturned,
                items: ['Not Returned', 'Returned'].map((statusReturned) {
                  return DropdownMenuItem(
                    value: statusReturned,
                    child: Text(statusReturned),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _statusReturned = value.toString();
                  });
                },
                decoration: InputDecoration(labelText: 'Returned Status'),
              ),

              const SizedBox(height: 10.0),

              ElevatedButton(
                  onPressed: _saveCustomer,
                  child: Text('Save Customer Details'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
