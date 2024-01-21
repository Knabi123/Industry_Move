// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:flutter/material.dart';
import 'package:company/src_user/order_user.dart';
import 'package:company/src/addproducttype.dart';

void main() {
  runApp(MaterialApp(home: BottomBar_User()));
}

class BottomBar_User extends StatefulWidget {
  const BottomBar_User({super.key});

  @override
  State<BottomBar_User> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar_User> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Addproducttype(),
    Order_user()
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: "Shop"),
          BottomNavigationBarItem(
              icon: Icon(Icons.description), label: "Order"),
        ],
      ),
    );
  }
}
