// import 'package:flutter/material.dart';
// import 'package:ma_solutions_cms/data/models/rentals/rental_model.dart';
// import '../../../database/rentals/rental_db.dart';
//
// class RentalEntryScreen extends StatefulWidget {
//   @override
//   _RentalEntryScreenState createState() => _RentalEntryScreenState();
// }
//
// class _RentalEntryScreenState extends State<RentalEntryScreen> {
//   List<Map<String, dynamic>> products = [];
//   List<Map<String, dynamic>> customers = [];
//
//   int? selectedProductId;
//   int? selectedCustomerId;
//   DateTime selectedRentalDate = DateTime.now();
//   DateTime? selectedReturnDate;
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController totalPriceController = TextEditingController();
//   TextEditingController statusController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadDropdownData();
//   }
//
//   Future<void> _loadDropdownData() async {
//     products = await RentalDB.getProducts();
//     customers = await RentalDB.getCustomers();
//     setState(() {}); // Refresh UI
//   }
//
//   Future<void> _saveRental() async {
//     if (selectedProductId == null || selectedCustomerId == null || quantityController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please fill all required fields.')));
//       return;
//     }
//
//     Rental newRental = Rental(
//       productId: selectedProductId.toString(),
//       customerId: selectedCustomerId.toString(),
//       rentalDate: selectedRentalDate.toIso8601String(),
//       returnDate: selectedReturnDate!.toIso8601String(),
//       quantity: int.parse(quantityController.text),
//       totalPrice: int.parse(totalPriceController.text),
//       status: statusController.text,
//     );
//
//     await RentalDB.insertRental(newRental);
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Rental entry saved.')));
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("New Rental Entry")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // Product Dropdown
//             DropdownButtonFormField<int>(
//               value: selectedProductId,
//               hint: Text("Select Product"),
//               items: products.map((product) {
//                 return DropdownMenuItem<int>(
//                   value: product['id'],
//                   child: Text(product['name']),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedProductId = value;
//                 });
//               },
//             ),
//
//             SizedBox(height: 10),
//
//             // Customer Dropdown
//             DropdownButtonFormField<int>(
//               value: selectedCustomerId,
//               hint: Text("Select Customer"),
//               items: customers.map((customer) {
//                 return DropdownMenuItem<int>(
//                   value: customer['id'],
//                   child: Text(customer['name']),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 setState(() {
//                   selectedCustomerId = value;
//                 });
//               },
//             ),
//
//             SizedBox(height: 10),
//
//             // Quantity
//             TextField(
//               controller: quantityController,
//               decoration: InputDecoration(labelText: "Quantity"),
//               keyboardType: TextInputType.number,
//             ),
//
//             // Total Price
//             TextField(
//               controller: totalPriceController,
//               decoration: InputDecoration(labelText: "Total Price"),
//               keyboardType: TextInputType.number,
//             ),
//
//             // Status
//             TextField(
//               controller: statusController,
//               decoration: InputDecoration(labelText: "Status"),
//             ),
//
//             SizedBox(height: 20),
//
//             // Save Button
//             ElevatedButton(
//               onPressed: _saveRental,
//               child: Text("Save Rental"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
