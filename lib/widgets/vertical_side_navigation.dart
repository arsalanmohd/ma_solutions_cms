import 'package:flutter/material.dart';

import '../utils/constants.dart'; // Ensure this file defines `defaultSpace`

class VerticalSideNavigationMenu extends StatefulWidget {
  final List<NavBarMenuItem> menuItems;
  final Function(int index)? onTap;
  final int? currentIndex;
  final double iconSize;

  const VerticalSideNavigationMenu({
    Key? key,
    required this.menuItems,
    this.onTap,
    this.currentIndex,
    required this.iconSize,
  }) : super(key: key);

  @override
  State<VerticalSideNavigationMenu> createState() => _VerticalSideNavigationMenuState();
}

class _VerticalSideNavigationMenuState extends State<VerticalSideNavigationMenu> {
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(defaultSpace / 2),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Colors.black12, width: .7),
        ),
      ),
      child: Column(
        children: [
          ...widget.menuItems.map((menu) {
            int menuIndex = widget.menuItems.indexOf(menu);
            return InkWell(
              onTap: () => _onItemTapped(menuIndex),
              child: Padding(
                padding: const EdgeInsets.only(top: defaultSpace * 3),
                child: Icon(
                  menu.icon,
                  color: _selectedIndex == menuIndex ? primaryColor : Colors.black26,
                  size: widget.iconSize,
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class NavBarMenuItem {
  final IconData icon;
  NavBarMenuItem({required this.icon});
}
