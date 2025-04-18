import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ma_solutions_cms/data/models/products/product_model.dart';
import 'package:ma_solutions_cms/data/database/products/product_db.dart';

class ProductEditScreen extends StatefulWidget {
  final Product product;

  const ProductEditScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late String _status;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _priceController = TextEditingController(text: widget.product.rentalPricePerDay.toString());
    _quantityController = TextEditingController(text: widget.product.availableQuantity.toString());
    const validStatuses = ['Active', 'Unavailable', 'Maintenance'];
    _status = validStatuses.contains(widget.product.status)
        ? widget.product.status
        : 'Active';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        // Optionally, store image path in DB later
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: widget.product.id,
        name: _nameController.text,
        rentalPricePerDay: double.parse(_priceController.text),
        availableQuantity: int.parse(_quantityController.text),
        status: _status,
        // Add image path if you save it in your DB
      );
      await ProductDB.updateProduct(updatedProduct);
      Navigator.pop(context, true); // Return true to indicate update success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Product')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_imageFile != null)
                Image.file(_imageFile!, height: 150)
              else
                const SizedBox(height: 150, child: Center(child: Text("No image selected"))),
              ElevatedButton(onPressed: _pickImage, child: const Text("Select Image")),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) => value!.isEmpty ? 'Enter product name' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Rental Price Per Day'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Available Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter quantity' : null,
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: ['Active', 'Unavailable', 'Maintenance'].map((status) {
                  return DropdownMenuItem(value: status, child: Text(status));
                }).toList(),
                onChanged: (value) {
                  setState(() => _status = value!);
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _saveChanges, child: const Text('Save Changes')),
            ],
          ),
        ),
      ),
    );
  }
}
