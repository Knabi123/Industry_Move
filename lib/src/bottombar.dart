// ignore_for_file: prefer_const_constructors

import 'package:company/src/Add_pro.dart';
import 'package:company/src/driverscreen.dart';
import 'package:company/src/orderscreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Add_Pro(),
    OrderScreen(),
    DriverDetailPage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color.fromRGBO(225, 190, 231, 1),
        color: Colors.deepPurple,
        index: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          Icon(
            Icons.store,
            color: Colors.white,
          ),
          Icon(
            Icons.list_alt,
            color: Colors.white,
          ),
          Icon(
            Icons.fire_truck,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
