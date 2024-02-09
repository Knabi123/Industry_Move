// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_typing_uninitialized_variables

import 'package:company/src/Type_User.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:company/src_user/order_user.dart';

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
    Type_User(),
    Order_user(),
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
        backgroundColor: Color.fromARGB(255, 4, 195, 248),
        color: Color.fromARGB(255, 1, 153, 255),
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
          )
        ],
      ),
    );
  }
}
