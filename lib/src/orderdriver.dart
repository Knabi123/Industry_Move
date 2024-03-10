// ignore: duplicate_ignore
// ignore_for_file: use_key_in_widget_constructors, unused_import, duplicate_ignore

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:company/src/orderlist.dart';
import 'package:company/src_user/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverOrderScreen extends StatefulWidget {
  @override
  _DriverOrderScreenState createState() => _DriverOrderScreenState();
}

class _DriverOrderScreenState extends State<DriverOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
        title: Text(
          'Order Driver',
          style: TextStyle(
            fontSize: 24, // ตั้งค่าขนาดตัวอักษร
            fontWeight: FontWeight.bold, // ตั้งค่าน้ำหนักตัวอักษร
            letterSpacing: 1.5, // ตั้งค่าระยะห่างระหว่างตัวอักษร
          ),
        ),
        centerTitle: true, // ทำให้ Title อยู่ตรงกลาง
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple[200],
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                    child: Text(
                  'L O G O',
                  style: TextStyle(fontSize: 35),
                )),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: OrderList(),
      ),
    );
  }
}
