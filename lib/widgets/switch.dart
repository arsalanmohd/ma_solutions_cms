import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({super.key});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35, width: 55,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: isSwitched ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Switch(
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
          });
        },
        activeColor: Colors.white,
        inactiveThumbColor: Colors.white.withOpacity(0.1),
      ),
    );
  }
}