import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/rentals/rental_model.dart';
import 'package:ma_solutions_cms/data/database/rentals/rental_db.dart';
import 'package:ma_solutions_cms/data/screens/rentals/rental_list_screen/rental_list_screen.dart';
import '../../../database/customers/customer_db.dart';
import '../../../database/products/product_db.dart';
import '../../../models/customers/customer_model.dart';
import '../../../models/products/product_model.dart';

class RentalEntryScreen extends StatefulWidget {
  @override
  _RentalEntryScreenState createState() => _RentalEntryScreenState();
}

class _RentalEntryScreenState extends State<RentalEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  int? _selectedProductId;
  int? _selectedCustomerId;
  DateTime _rentalDate = DateTime.now();
  DateTime? _returnDate;
  final _quantityController = TextEditingController();
  final _totalPriceController = TextEditingController();
  String _status = 'Active';

  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _customers = [];

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    List<Product> productList = await ProductDB.getAllProducts();
    List<Customer> customerList = await CustomerDB.getAllCustomers();

    // Convert to List<Map<String, dynamic>>
    _products = productList.map((product) => {
      'id': product.id,
      'name': product.name,
    }).toList();

    _customers = customerList.map((customer) => {
      'id': customer.id,
      'name': customer.name,
    }).toList();

    setState(() {});
  }

  void _saveRental() async {
    if (_formKey.currentState!.validate() && _selectedProductId != null && _selectedCustomerId != null) {
      int rentalQty = int.parse(_quantityController.text);

      // Fetch current product details
      Product? product = await ProductDB.getProductById(_selectedProductId!);
      if (product == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Product not found')));
        return;
      }

      // Check if enough stock is available
      if (product.availableQuantity < rentalQty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Not enough stock available')));
        return;
      }

      // Deduct product quantity
      product.availableQuantity -= rentalQty;
      await ProductDB.updateProduct(product); // Make sure this method exists

      // Save rental
      final rental = Rental(
        productId: _selectedProductId!,
        customerId: _selectedCustomerId!,
        rentalDate: _rentalDate.toIso8601String(),
        returnDate: _returnDate?.toIso8601String(),
        quantity: rentalQty,
        totalPrice: double.parse(_totalPriceController.text),
        status: _status,
      );
      await RentalDB.insertRental(rental);

      Navigator.pop(context, true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Entry'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DropdownButtonFormField<int>(
                  value: _selectedProductId,
                  hint: Text("Select Product"),
                  items: _products.map((product) {
                    return DropdownMenuItem<int>(
                      value: product['id'],
                      child: Text(product['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedProductId = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Product'),
                ),
                DropdownButtonFormField<int>(
                  value: _selectedCustomerId,
                  hint: Text("Select Customer"),
                  items: _customers.map((customer) {
                    return DropdownMenuItem<int>(
                      value: customer['id'],
                      child: Text(customer['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCustomerId = value;
                    });
                  },
                  decoration: InputDecoration(labelText: 'Customer'),
                ),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Quantity'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter Quantity' : null,
                ),
                TextFormField(
                  controller: _totalPriceController,
                  decoration: InputDecoration(labelText: 'Total Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Enter Total Price' : null,
                ),
                DropdownButtonFormField(
                  value: _status,
                  items: ['Active', 'Completed', 'Cancelled'].map((status) {
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
                  onPressed: _saveRental,
                  child: Text('Save Rental'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
