import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/widgets/inventory_warning_text.dart';

import '../data/database/products/product_db.dart';
import '../data/models/products/product_model.dart';

class InventoryWarningSlider extends StatefulWidget {
  const InventoryWarningSlider({
    super.key,
  });

  @override
  _InventoryWarningSliderState createState() => _InventoryWarningSliderState();
}

class _InventoryWarningSliderState extends State<InventoryWarningSlider> {
  late List<Product> lowStockProducts = [];

  @override
  void initState() {
    super.initState();
    _loadLowStockProducts();
  }

  Future<void> _loadLowStockProducts() async {
    List<Product> products = await ProductDB.getAllProducts();
    // Filter products with less than 5 quantity
    setState(() {
      lowStockProducts = products.where((product) => product.availableQuantity < 5).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: lowStockProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final product = lowStockProducts[index];
          return InventoryWarningText(
            title: product.name,
            inventory: product.availableQuantity.toString(),
            backgroundColor: Colors.red.shade200,
          );
        },
      ),
    );
  }
}