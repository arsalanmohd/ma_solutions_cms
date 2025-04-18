import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_solutions_cms/data/screens/login_screen.dart';
import '../utils/constants.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(defaultSpace/2),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12, width: .7),),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultSpace),
            child: SizedBox(
                height: 25,
                child: Image(image: AssetImage('images/logo for light.png'))
            ),
          ),


      // -------------------- Icons on right of App bar/ Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultSpace),
            child: Row(
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: iconBackdropColor
                  ),
                  child: Icon(Icons.notifications, size: 17, color: Colors.black54,),
                ),
                const SizedBox(
                  width: defaultSpace,
                ),
                Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: primaryColor
                  ),
                  child: Icon(Icons.person, size: 17, color: Colors.white,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}