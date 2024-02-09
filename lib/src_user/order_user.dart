// ignore_for_file: use_key_in_widget_constructors, camel_case_types, sort_child_properties_last, prefer_const_constructors

import 'package:company/src_user/login.dart';
import 'package:flutter/material.dart';
import 'order_detail_user.dart';

void main() {
  runApp(MaterialApp(home: Order_user()));
}

class Order_user extends StatelessWidget {
  final List<String> orderList = ["Order 1", "Order 2", "Order 3", "Order 4"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 228, 255),
        centerTitle: true, // เพิ่มบรรทัดนี้
        title: const Text(
          'My Order',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage()), // HomePage() เป็นหน้าหลักหรือหน้าที่ต้องการ
            );
          },
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
        elevation: 4.0,
      ),
      body: Container(
        padding: EdgeInsets.all(8.0), // เพิ่ม padding ตามความต้องการ
        child: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        OrderDetailsPage(selectedOrder: orderList[index]),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 250, 250, 250),
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                  border: Border.all(color: Colors.black),
                ),
                height: 100,
                child: Center(
                  child: Text(
                    orderList[index],
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
