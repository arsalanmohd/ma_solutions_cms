import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/products/product_model.dart';
import 'package:ma_solutions_cms/utils/constants.dart';
import '../../../../widgets/search_bar_with_buttons.dart';
import '../../../database/products/product_db.dart';
import '../product_edit_screen/product_edit_screen.dart';
import '../product_entry_screen/product_entry_scren.dart';
import 'dart:io';


class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Iterable<TableRow>? productList = [];
  Iterable<TableRow>? filteredProductList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await _loadProductData();

      setState(() {
        productList = productList?.map((product) => _buildProductRowTile(product as Product)).toList();
      });
    });
  }

  Future<void> _loadProductData() async {
    List<Product> productEntries = (await ProductDB.getAllProducts());
    setState(() {
      productList = productEntries.map((product) => _buildProductRowTile(product)).toList();
      filteredProductList = List.from(productList as Iterable);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(defaultSpace),
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
                    onChanged: (searchTerm) {
                      if (searchTerm.length >= 2) {
                        Future.delayed(Duration(seconds: 1), () async {
                          List<Product> productEntries = await ProductDB.getAllProducts(); // Fetch Data
                          setState(() {
                            filteredProductList = productEntries
                                .where((product) =>
                            product.name.contains(searchTerm) ||
                                product.status.contains(searchTerm))
                                .map((product) => _buildProductRowTile(product));
                            productList = filteredProductList; // Update the display list
                          });
                        });
                      } else if (searchTerm.isEmpty) {
                        _loadProductData(); // Reset to full database data
                      }
                    },

                    onTapAdd: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProductEntryScreen()),
                      );

                      if (result == true) {
                        await _loadProductData(); // Fetch latest data from the database
                      }
                    },
                  ),

// ----------------------------------------------------------------------------------------------------
                  SizedBox(height: 20.0,),

                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(60.0), // ID
                      // 1: FlexColumnWidth(60.0),       // Name
                      // 2: FixedColumnWidth(100.0), // Rent
                      // 3: FixedColumnWidth(100.0), // Quantity
                      // 4: FixedColumnWidth(80.0),  // Status
                      // 5: FixedColumnWidth(50.0),  // Edit
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
                      _buildProductHeader(),
                      ...?productList,
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

  TableRow _buildProductRowTile(Product product) {
    return TableRow(
      key: ValueKey(product.hashCode),
      children: [

        // id
        _buildProductItem(
            child: Text(
              product.id.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildProductItem(
          child: product.photoPath != null && product.photoPath!.isNotEmpty
              ? Image.file(
            File(product.photoPath!),
            height: 10,
            width: 10,
            fit: BoxFit.cover,
          )
              : Icon(Icons.image_not_supported, color: Colors.grey),
        ),

        _buildProductItem(
            child: Text(
              product.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildProductItem(
            child: Text(
              '\₹${product.rentalPricePerDay.toString()}',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildProductItem(
            child: Text(
              product.availableQuantity.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildProductItem(
            child: Text(
              product.status,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildProductItem(
          child: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductEditScreen(product: product),
                ),
              );
            },
          ),
        ),

      ]
    );
  }

  TableRow _buildProductHeader() {
    return TableRow(
        children: [


          _buildProductItem(
            child: Text('Id'),
          ),
          _buildProductItem(
            child: Text('Image'),
          ),
          _buildProductItem(
            child: Text('Product Name'),
          ),
          _buildProductItem(
            child: Text('Rent per Day'),
          ),
          _buildProductItem(
            child: Text('Available Quantity'),
          ),
          _buildProductItem(
            child: Text('Status'),
          ),
          _buildProductItem(
            child: Text(''), // For Edit Icon
          ),


        ]
    );
  }

  TableCell _buildProductItem({required Widget child}) {
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