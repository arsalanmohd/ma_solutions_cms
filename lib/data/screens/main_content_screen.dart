import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/database/add_entry.dart';
import 'package:ma_solutions_cms/data/models/dashboard_model.dart';
import 'package:ma_solutions_cms/widgets/switch.dart';
import '../../utils/constants.dart';
import '../../widgets/search_bar_with_buttons.dart';
import '../database/db_helper.dart';

class MainContent extends StatefulWidget {
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {

  Iterable<TableRow>? dashboardList = [];
  Iterable<TableRow>? filteredDashboardList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{

      await _loadDashboardData();

      setState(() {
        dashboardList = dashboardList?.map((dashboard) => _buildDashboardRowTile(dashboard as Dashboard)).toList();
      });
    });
  }

  Future<void> _loadDashboardData() async {
    List<Dashboard> dashboardEntries = (await DBHelper.getAllDashboards());
    setState(() {
      dashboardList = dashboardEntries.map((dashboard) => _buildDashboardRowTile(dashboard)).toList();
      filteredDashboardList = dashboardList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height, padding: const EdgeInsets.all(defaultSpace),
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
                          List<Dashboard> dashboardEntries = await DBHelper.getAllDashboards(); // Fetch fresh data
                          setState(() {
                            filteredDashboardList = dashboardEntries
                                .where((dashboard) =>
                            dashboard.dCustomerNumber.contains(searchTerm) ||
                                dashboard.dProductName.contains(searchTerm))
                                .map((dashboard) => _buildDashboardRowTile(dashboard));
                            dashboardList = filteredDashboardList; // Update the displayed list
                          });
                        });
                      } else if (searchTerm.isEmpty) {
                        _loadDashboardData(); // Reset to full database data
                      }
                    },

                    onTapAdd: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEntryScreen()),
                      );

                      if (result == true) {
                        await _loadDashboardData(); // Fetch latest data from the database
                      }
                    },
                  ),

// -------------------------------------------------------------------------------------------
                  SizedBox(height: 20.0,),

                  Table(
                    columnWidths: const {
                      0: FixedColumnWidth(160.0),
                      1: FixedColumnWidth(130.0),
                      2: FixedColumnWidth(160.0),
                      3: FixedColumnWidth(130.0),
                      4: FixedColumnWidth(160.0),
                      5: FixedColumnWidth(130.0),
                      6: FixedColumnWidth(160.0),
                      7: FixedColumnWidth(130.0),
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
                      _buildDashboardHeader(),
                      ...?dashboardList,
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

  TableRow _buildDashboardRowTile(Dashboard dashboard) {
    return TableRow(
      key: ValueKey(dashboard.hashCode),
      children: [


        // Customer Name
        _buildDashboardItem(
          child: Text(
            dashboard.dCustomerName,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.black87.withOpacity(0.7)),
          )
        ),

        // Product Name
        _buildDashboardItem(
            child: Text(
              dashboard.dProductName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black87.withOpacity(0.7)),
            )
        ),

        // Customer Number
        _buildDashboardItem(
            child: Text(
              dashboard.dCustomerNumber,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black87.withOpacity(0.7)),
            )
        ),

        // Customer Occupation
        _buildDashboardItem(
            child: Text(
              dashboard.dOccupation,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black87.withOpacity(0.7)),
            )
        ),

        // Date
        _buildDashboardItem(
            child: Text(
              dashboard.date,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black87.withOpacity(0.7)),
            )
        ),

        // Amount
        _buildDashboardItem(
            child: Text(
              dashboard.dPrice.toString(),
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.black87.withOpacity(0.7)),
            )
        ),

        // Payment Status
        _buildDashboardItem(

          child: CustomSwitch()
        ),

        // Receive Status
        _buildDashboardItem(

          child: CustomSwitch()
        ),


      ]
    );
  }

  TableRow _buildDashboardHeader() {
    return TableRow(
      children: [


        _buildDashboardItem(
          child: Text('Customer Name'),
        ),

        _buildDashboardItem(
          child: Text('Product Name'),
        ),

        _buildDashboardItem(
          child: Text('Customer Number'),
        ),

        _buildDashboardItem(
          child: Text('Occupation'),
        ),

        _buildDashboardItem(
          child: Text('Date'),
        ),

        _buildDashboardItem(
          child: Text('Amount'),
        ),

        _buildDashboardItem(
          child: Text('Paid?'),
        ),

        _buildDashboardItem(
          child: Text('Received?'),
        ),


      ]
    );
  }

  TableCell _buildDashboardItem({required Widget child}) {
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

  payStatus(PaymentStatus pStatus){
    switch(pStatus){
      case PaymentStatus.due:
      return "Not Paid";
      case PaymentStatus.paid:
        return "Paid";
    }
  }

  receivingStatus(ReceiveStatus rStatus){
    switch(rStatus){
      case ReceiveStatus.notReceived:
        return "Not Received";
      case ReceiveStatus.received:
        return "Received";
    }
  }

}