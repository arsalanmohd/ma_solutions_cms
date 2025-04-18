// import 'package:flutter/material.dart';
// import 'package:ma_solutions_cms/data/dashboard_data.dart';
// import 'package:ma_solutions_cms/data/models/dashboard_model.dart';
// import 'package:ma_solutions_cms/data/screens/dashboard_data_enter_screen.dart';
// import 'package:ma_solutions_cms/widgets/switch.dart';
//
// import '../../utils/constants.dart';
// import '../../widgets/search_bar_with_buttons.dart';
//
// class MainContent extends StatefulWidget {
//   const MainContent({super.key});
//
//   @override
//   State<MainContent> createState() => _MainContentState();
// }
//
// class _MainContentState extends State<MainContent> {
//
//   Iterable<TableRow>? dashboardList;
//   Iterable<TableRow>? filteredDashboardList;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       setState(() {
//         dashboardList = dashboardInventoryList.map((dashboard) => _buildDashboardRowTile(dashboard)).toList();
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Flexible(
//           child: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height, padding: const EdgeInsets.all(defaultSpace),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.rectangle,
//               borderRadius: BorderRadius.circular(defaultSpace / 2),
//             ),
//             margin: const EdgeInsets.only(
//                 top: defaultSpace * 2,
//                 left: defaultSpace,
//                 right: defaultSpace * 2,
//                 bottom: defaultSpace * 3),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SearchBarWithButtons(
//                     onChanged: (searchTerm) {
//                       if(searchTerm.length >= 2) {
//                         Future.delayed(Duration(seconds: 1), (){
//
//                           filteredDashboardList =
//                               dashboardInventoryList.where((
//                                   dashboard) =>
//                               dashboard.dCustomerNumber.contains(searchTerm)
//                                   || dashboard.dCustomerNumber.contains(searchTerm)
//                                   || dashboard.dProductName.contains(searchTerm))
//                                   .map((dashboard) =>
//                                   _buildDashboardRowTile(dashboard));
//
//                           setState(() {
//                             dashboardList = filteredDashboardList;
//
//                           });
//                         });
//                       } else if(searchTerm.isEmpty == true) {
//                         setState(() {
//                           dashboardList = dashboardInventoryList
//                               .map((dashboard) =>
//                               _buildDashboardRowTile(dashboard));
//                         });
//                       }
//                     },
//                     onTapFilter: () {print("Filter Pressed");},
//                     onTapExport: () {print("Export Pressed");},
//                     onTapAdd: () {print("Add Pressed"); Navigator.push(context, MaterialPageRoute(builder: (context) => const DataEntryScreen()));},
//                   ),
//
// // -------------------------------------------------------------------------------------------
//                   SizedBox(height: 20.0,),
//
//                   Table(
//                     columnWidths: const {
//                       0: FixedColumnWidth(160.0),
//                       1: FixedColumnWidth(130.0),
//                       2: FixedColumnWidth(160.0),
//                       3: FixedColumnWidth(130.0),
//                       4: FixedColumnWidth(160.0),
//                       5: FixedColumnWidth(130.0),
//                       6: FixedColumnWidth(160.0),
//                       7: FixedColumnWidth(130.0),
//                     },
//                     border: TableBorder(
//                         top: BorderSide(
//                             color: Colors.grey.withOpacity(0.1), width: 1),
//                         bottom: BorderSide(
//                             color: Colors.grey.withOpacity(0.1), width: 1),
//                         horizontalInside: BorderSide(
//                             color: Colors.grey.withOpacity(0.1), width: 1)
//                     ),
//                     children: [
//                       _buildDashboardHeader(),
//                       ...?dashboardList
//                     ],
//                   ),
//
//                 ],
//               ),
//             ),
//
//           ),
//         ),
//       ],
//     );
//   }
//
//   TableRow _buildDashboardRowTile(Dashboard dashboard) {
//     return TableRow(
//         key: ValueKey(dashboard.hashCode),
//         children: [
//           // // Check Box
//           // _buildDashboardItem(
//           //     child: Checkbox(
//           //         side: const BorderSide(color: Colors.grey, width: 1),
//           //         focusColor: Colors.black45,
//           //         value: false, onChanged: (value) {})
//           // ),
//
//           // Customer Name
//           _buildDashboardItem(
//               child: Text(
//                 dashboard.dCustomerName,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black87.withOpacity(0.7)),
//               )
//           ),
//
//           // Product Name
//           _buildDashboardItem(
//               child: Text(
//                 dashboard.dProductName,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black87.withOpacity(0.7)),
//               )
//           ),
//
//           // Customer Number
//           _buildDashboardItem(
//               child: Text(
//                 dashboard.dCustomerNumber,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black87.withOpacity(0.7)),
//               )
//           ),
//
//           // Customer Occupation
//           _buildDashboardItem(
//               child: Text(
//                 dashboard.dOccupation.name,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black87.withOpacity(0.7)),
//               )
//           ),
//
//           // Date
//           _buildDashboardItem(
//               child: Text(
//                 dashboard.date,
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black87.withOpacity(0.7)),
//               )
//           ),
//
//           // Amount
//           _buildDashboardItem(
//               child: Text(
//                 dashboard.dPrice.toString(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .bodyMedium
//                     ?.copyWith(color: Colors.black87.withOpacity(0.7)),
//               )
//           ),
//
//           // Payment Status
//           _buildDashboardItem(
//             // child: Container(
//             //   height: 35, width: 120,
//             //   decoration: BoxDecoration(
//             //       shape: BoxShape.rectangle,
//             //       borderRadius: BorderRadius.circular(50),
//             //       color: dashboard.pStatus == PaymentStatus.paid
//             //           ? Colors.green.withOpacity(0.3)
//             //           : Colors.red.withOpacity(0.3)
//             //   ),
//             //   child: Center(
//             //     child: Text(
//             //       payStatus(dashboard.pStatus),
//             //       style: Theme.of(context)
//             //           .textTheme
//             //           .bodyMedium
//             //           ?.copyWith(color: dashboard.pStatus == PaymentStatus.paid
//             //           ? Colors.green
//             //           : Colors.red,
//             //       ),
//             //     ),
//             //   ),
//             // )
//               child: CustomSwitch()
//           ),
//
//           // Receive Status
//           _buildDashboardItem(
//             // child: Container(
//             //   height: 35, width: 120,
//             //   decoration: BoxDecoration(
//             //       shape: BoxShape.rectangle,
//             //       borderRadius: BorderRadius.circular(50),
//             //       color: dashboard.rStatus == ReceiveStatus.received
//             //           ? Colors.green.withOpacity(0.3)
//             //           : Colors.red.withOpacity(0.3)
//             //   ),
//             //   child: Center(
//             //     child: Text(
//             //       receivingStatus(dashboard.rStatus),
//             //       style: Theme.of(context)
//             //           .textTheme
//             //           .bodyMedium
//             //           ?.copyWith(color: dashboard.rStatus == ReceiveStatus.received
//             //           ? Colors.green
//             //           : Colors.red,
//             //       ),
//             //     ),
//             //   ),
//             // )
//               child: CustomSwitch()
//           ),
//
//           // // Action Button
//           // TableCell(
//           //     child: Container(
//           //       padding: EdgeInsets.symmetric(vertical: defaultSpace + 6),
//           //       child: Center(
//           //         child: Container(
//           //           height: 25,
//           //           width: 25,
//           //           decoration: BoxDecoration(
//           //               shape: BoxShape.rectangle,
//           //               color: backgroundColor,
//           //               borderRadius: BorderRadius.circular(5)
//           //           ),
//           //           child: Icon(Icons.more_horiz, color: Colors.black.withOpacity(0.7),),
//           //         ),
//           //       ),
//           //     ))
//         ]
//     );
//   }
//
//   TableRow _buildDashboardHeader() {
//     return TableRow(
//         children: [
//           // _buildDashboardItem(
//           //   child: Padding(
//           //   padding: EdgeInsets.all(defaultSpace / 2),
//           //   child: Checkbox(
//           //   value: false, onChanged: (value) {}),
//           // ),),
//
//           _buildDashboardItem(
//             child: Text('Customer Name'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Product Name'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Customer Number'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Occupation'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Date'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Amount'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Paid?'),
//           ),
//
//           _buildDashboardItem(
//             child: Text('Received?'),
//           ),
//
//           // _buildDashboardItem(
//           //   child: Container(),
//           // ),
//         ]
//     );
//   }
//
//   TableCell _buildDashboardItem({required Widget child}) {
//     return TableCell(
//       verticalAlignment: TableCellVerticalAlignment.middle,
//       child: SizedBox(
//         height: 70,
//         child: Center(
//           child: child,
//         ),
//       ),
//     );
//   }
//
//   payStatus(PaymentStatus pStatus){
//     switch(pStatus){
//       case PaymentStatus.due:
//         return "Not Paid";
//       case PaymentStatus.paid:
//         return "Paid";
//     }
//   }
//
//   receivingStatus(ReceiveStatus rStatus){
//     switch(rStatus){
//       case ReceiveStatus.notReceived:
//         return "Not Received";
//       case ReceiveStatus.received:
//         return "Received";
//     }
//   }
//
// }