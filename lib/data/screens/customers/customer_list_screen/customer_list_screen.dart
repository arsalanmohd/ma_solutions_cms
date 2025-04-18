import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/models/customers/customer_model.dart';
import 'package:ma_solutions_cms/utils/constants.dart';
import 'package:ma_solutions_cms/widgets/search_bar_with_buttons.dart';
import 'package:ma_solutions_cms/data/database/customers/customer_db.dart';
import 'package:ma_solutions_cms/data/screens/customers/customer_entry_screen/customer_entry_screen.dart';


class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  Iterable<TableRow>? customerList = [];
  Iterable<TableRow>? filteredCustomerList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await _loadCustomerData();
      setState(() {
        customerList = customerList?.map((customer) => _buildCustomerRowTile(customer as Customer)).toList();
      });
    });
  }

  Future<void> _loadCustomerData() async {
    List<Customer> customerEntries = (await CustomerDB.getAllCustomers());
    setState(() {
      customerList = customerEntries.map((customer) => _buildCustomerRowTile(customer)).toList();
      filteredCustomerList = List.from(customerList as Iterable);
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
                          List<Customer> customerEntries = await CustomerDB.getAllCustomers(); // Fetch Data
                          setState(() {
                            filteredCustomerList = customerEntries
                                .where((customer) =>
                            customer.name.contains(searchTerm) ||
                                customer.contact.contains(searchTerm) ||
                                customer.occupation.contains(searchTerm) ||
                                customer.address.contains(searchTerm))
                                .map((product) => _buildCustomerRowTile(product));
                            customerList = filteredCustomerList; // Update the display list
                          });
                        });
                      } else if (searchTerm.isEmpty) {
                        _loadCustomerData(); // Reset to full database data
                      }
                    },

                    onTapAdd: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CustomerEntryScreen()),
                      );

                      if (result == true) {
                        await _loadCustomerData(); // Fetch latest data from the database
                      }
                    },
                  ),

// ------------------------------------------------------------------------------------------------
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
                      _buildCustomerHeader(),
                      ...?customerList,
                    ],
                  ),


                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  TableRow _buildCustomerRowTile(Customer customer) {
    return TableRow(
      key: ValueKey(customer.hashCode),
      children: [

        _buildCustomerItem(
            child: Text(
              customer.id.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors.black87.withOpacity(0.7)),
            )
        ),

        _buildCustomerItem(
            child: Text(
              customer.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors
                      .black87
                      .withOpacity(0.7))
              ,
            )
        ),

        _buildCustomerItem(
            child: Text(
              customer.contact,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors
                      .black87
                      .withOpacity(0.7))
              ,
            )
        ),

        _buildCustomerItem(
            child: Text(
              customer.address,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors
                      .black87
                      .withOpacity(0.7))
              ,
            )
        ),

        _buildCustomerItem(
            child: Text(
              customer.occupation,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors
                      .black87
                      .withOpacity(0.7))
              ,
            )
        ),

        _buildCustomerItem(
            child: Text(
              customer.statusPaid,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors
                      .black87
                      .withOpacity(0.7))
              ,
            )
        ),

        _buildCustomerItem(
            child: Text(
              customer.statusReturned,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                  color: Colors
                      .black87
                      .withOpacity(0.7))
              ,
            )
        ),

      ]
    );
  }

  TableRow _buildCustomerHeader() {
    return TableRow(
      children: [

        _buildCustomerItem(
            child: Text('Id'),
        ),

        _buildCustomerItem(
          child: Text('Customer Name'),
        ),

        _buildCustomerItem(
          child: Text('Contact Number'),
        ),

        _buildCustomerItem(
          child: Text('Address'),
        ),

        _buildCustomerItem(
          child: Text('Occupation'),
        ),

        _buildCustomerItem(
          child: Text('Payment Status'),
        ),

        _buildCustomerItem(
          child: Text('Equipments Received?'),
        ),
      ]
    );
  }

  TableCell _buildCustomerItem({required Widget child}) {
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