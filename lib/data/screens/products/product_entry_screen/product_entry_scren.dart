import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ma_solutions_cms/data/models/products/product_model.dart';
import '../../../database/products/product_db.dart';

class ProductEntryScreen extends StatefulWidget {
  @override
  _ProductEntryScreenState createState() => _ProductEntryScreenState();
}

class _ProductEntryScreenState extends State<ProductEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _rentalPriceController = TextEditingController();
  final _quantityController = TextEditingController();
  String _status = 'Available';
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = File(picked.path);
      });
    }
  }

  void _saveProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        name: _nameController.text,
        rentalPricePerDay: int.parse(_rentalPriceController.text),
        availableQuantity: int.parse(_quantityController.text),
        status: _status,
      );
      await ProductDB.insertProduct(product);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Entry'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_imageFile != null)
                  Image.file(_imageFile!, height: 150)
                else
                  const SizedBox(height: 150, child: Center(child: Text("No image selected"))),
                ElevatedButton(onPressed: _pickImage, child: const Text("Select Image")),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Product Name'),
                  validator: (value) => value!.isEmpty ? 'Enter Product Name' : null,
                ),
                TextFormField(
                  controller: _rentalPriceController,
                  decoration: InputDecoration(labelText: 'Rental Price Per Day'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter Price' : null,
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Available Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter Quantity' : null,
                ),
                DropdownButtonFormField(
                  value: _status,
                  items: ['Available', 'Not Available'].map((status) {
                    return DropdownMenuItem(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _status = value.toString();
                    });
                  },
                  decoration: InputDecoration(labelText: 'Status'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveProduct,
                  child: Text('Save Product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


