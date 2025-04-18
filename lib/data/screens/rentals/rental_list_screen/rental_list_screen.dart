import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/database/rentals/rental_db.dart';
import 'package:ma_solutions_cms/data/models/rentals/rental_model.dart';
import 'package:ma_solutions_cms/utils/constants.dart';
import 'package:ma_solutions_cms/widgets/inventory_warning_slider.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../widgets/search_bar_with_buttons.dart';
import 'package:ma_solutions_cms/data/screens/rentals/rental_entry_screen/rental_entry_screen.dart';

import '../../../database/customers/customer_db.dart';
import '../../../database/products/product_db.dart';
import '../../../models/customers/customer_model.dart';
import '../../../models/products/product_model.dart';

class RentalListScreen extends StatefulWidget {
  const RentalListScreen({super.key});

  @override
  State<RentalListScreen> createState() => _RentalListScreenState();
}

class _RentalListScreenState extends State<RentalListScreen> {
  Iterable<TableRow>? rentalList = [];
  Iterable<TableRow>? filteredRentalList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await _loadRentalData();

    });
  }

  Future<void> _loadRentalData() async{
    List<Rental> rentalEntries = await RentalDB.getALLRentals();
    // Fetch all customers and products once (optional optimization)
    final customers = await CustomerDB.getAllCustomers();  // Replace with your actual method
    final products = await ProductDB.getAllProducts();      // Replace with your actual method

    setState(() {
      rentalList = rentalEntries.map((rental) {
        // Find the customer and product names using the rental's IDs
        final customerName = customers.firstWhere(
              (c) => c.id == rental.customerId,
          orElse: () => Customer(id: rental.customerId, name: 'Unknown', contact: '', address: '', occupation: '', statusPaid: '', statusReturned: ''),
        ).name;

        final productName = products.firstWhere(
              (p) => p.id == rental.productId,
          orElse: () => Product(id: rental.productId, name: 'Unknown', rentalPricePerDay: 0, availableQuantity: 0, status: ''),
        ).name;

        // Pass customerName and productName to _buildRentalRowTile
        return _buildRentalRowTile(rental, customerName, productName);
      }).toList();
      filteredRentalList = rentalList;
    });
  }

  Future<void> deleteItem(int id) async {
    final db = await openDatabase('rental.db');
    await db.delete('rentals', where: 'id = ?', whereArgs: [id]);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(defaultSpace),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(defaultSpace / 2),
              ),
              margin: const EdgeInsets.only(
                  top: defaultSpace * 2,
                  left: defaultSpace,
                  right: defaultSpace * 2,
                  bottom: defaultSpace * 3),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchBarWithButtons(
                      onChanged: (searchTerm) { },

                      onTapAdd: () async {
                        bool? result = await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RentalEntryScreen()),
                        );

                        if (result == true) {
                          await _loadRentalData(); // Fetch latest data from the database
                        }
                      },
                    ),

// ----------------------------------------------------------------------------------------------------------------

                    SizedBox(height: 20.0,),

                    InventoryWarningSlider(),

                    SizedBox(height: 20.0,),

                    Table(
                      columnWidths: const {
                        0: FixedColumnWidth(100.0),
                      },

                      border: TableBorder(
                          top: BorderSide(
                              color: Colors.grey.withOpacity(0.1), width: 1),
                          bottom: BorderSide(
                              color: Colors.grey.withOpacity(0.1), width: 1),
                          horizontalInside: BorderSide(
                              color: Colors.grey.withOpacity(0.1), width: 1)
                      ),
                      children: [
                        _buildRentalHeader(),
                        ...?rentalList,
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ),
      ],
    );
  }

  TableRow _buildRentalRowTile(Rental rental, String customerName, String productName) {
    bool? isReturned = rental.returnDate?.isNotEmpty; // Check if returnDate is set

    return TableRow(
      key: ValueKey(rental.id),
      children: [

        _buildRentalItem(
          child: Text(
            rental.id.toString(),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
                color: Colors.black87.withOpacity(0.7)),
          )
        ),

        _buildRentalItem(
            child: Text(
              productName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
            child: Text(
              customerName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
            child: Text(
              rental.rentalDate,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
            child: Text(
              rental.returnDate == null || rental.returnDate!.isEmpty ? 'Not Returned' : rental.returnDate!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
            child: Text(
              rental.quantity.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
            child: Text(
              '\₹${rental.totalPrice.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
            child: Text(
              rental.status,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildRentalItem(
          child: Switch(
            value: isReturned ?? false,
            onChanged: (value) async {
              if (value) {
                String currentDate = DateTime.now().toIso8601String();

                // Update return date in rental
                await RentalDB.updateReturnDate(rental.id!, currentDate);

                // Restore product Quantity
                Product? product = await ProductDB.getProductById(rental.productId);
                if (product != null) {
                  product.availableQuantity += rental.quantity;
                  await ProductDB.updateProduct(product);
                }

                setState(() {
                  rental.returnDate = currentDate; // Update UI
                });
              }
            },
          ),
        ),

        _buildRentalItem(
            child: IconButton(onPressed: () async {
              await deleteItem(rental.id!);
              setState(() {});
            }, icon: Icon(Icons.delete))
        ),

      ]
    );

  }

  TableRow _buildRentalHeader() {
    return TableRow(
      children: [

        _buildRentalItem(
          child: Text('Id'),
        ),

        _buildRentalItem(
          child: Text('Product'),
        ),

        _buildRentalItem(
          child: Text('Customer Name'),
        ),

        _buildRentalItem(
          child: Text('Rental Date'),
        ),

        _buildRentalItem(
          child: Text('Return Date'),
        ),

        _buildRentalItem(
          child: Text('Quantity'),
        ),

        _buildRentalItem(
          child: Text('Total Price'),
        ),

        _buildRentalItem(
          child: Text('Returned?'),
        ),

        _buildRentalItem(
          child: Container(),
        ),

        _buildRentalItem(
          child: Container(),
        ),

      ]
    );
  }

  TableCell _buildRentalItem({required Widget child}) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: SizedBox(
        height: 70,
        child: Center(
          child: child,
        ),
      ),
    );
  }

}