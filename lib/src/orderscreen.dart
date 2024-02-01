// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:company/src/orderdetail.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  final List<String> orderList = ["Order 1", "Order 2", "Order 3", "Order 4"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 176, 42, 220),
        centerTitle: true,
        title: const Text(
          'My Orders',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
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
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orderList.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Orderdetail(),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
