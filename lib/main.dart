import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/screens/customers/customer_list_screen/customer_list_screen.dart';
import 'package:ma_solutions_cms/data/screens/payment/payment_list_screen/payment_list_screen.dart';
import 'package:ma_solutions_cms/data/screens/products/product_list_screen/product_list_screen.dart';
import 'package:ma_solutions_cms/data/screens/rentals/rental_list_screen/rental_list_screen.dart';
import 'package:ma_solutions_cms/data/screens/settings/settings_screen.dart';
import 'package:ma_solutions_cms/data/screens/user/user_list_screen/user_list_screen.dart';
import 'package:ma_solutions_cms/widgets/app_header.dart';
import 'package:ma_solutions_cms/widgets/vertical_side_navigation.dart';
import 'package:ma_solutions_cms/utils/constants.dart';
import 'data/screens/main_content_screen.dart';
import 'package:sqflite/sqflite.dart';





Future main() async {

WidgetsFlutterBinding.ensureInitialized();

WidgetsFlutterBinding.ensureInitialized();
runApp(const MyApp());



}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Customer Manager',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const Main(),
    );
  }
}


class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  var currentIndex = 0;
  @override
  Widget build(BuildContext context) {

//  ---------------   Set route to pages from navigation bar from here
    Widget buildMainContent({required int currentPage}) {
      switch(currentPage){
        case 0: return const RentalListScreen();
        case 1: return const ProductListScreen();
        case 2: return const CustomerListScreen();
        case 3: return const PaymentListScreen();
        case 4: return SettingsScreen();
        default:
          return const RentalListScreen();
      }
    }
    return Scaffold(
      body: Container(
        color: backgroundColor,
        child: Column(
          children: [
            // Header
            const AppHeader(),
            // Menu and content
            Expanded(child: Row(
              children: [
                VerticalSideNavigationMenu(
                    onTap: (int index) {
                      print(index);
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    currentIndex: currentIndex,
                    menuItems: [
                      NavBarMenuItem(icon: CupertinoIcons.rectangle_3_offgrid_fill),
                      NavBarMenuItem(icon: CupertinoIcons.collections_solid),
                      NavBarMenuItem(icon: CupertinoIcons.group_solid),
                      NavBarMenuItem(icon: Icons.payment),
                      NavBarMenuItem(icon: Icons.settings),
                    ],
                    iconSize: 25),

                // Main content area
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: defaultSpace * 2, top: defaultSpace * 2),
                      child: Text("Welcome Al-Zaid!", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),),
                    ),
                    Expanded(child: buildMainContent(currentPage: currentIndex),),
                  ],
                ),),
              ],
            ),),
          ],
        ),
      ),
    );
  }
}

