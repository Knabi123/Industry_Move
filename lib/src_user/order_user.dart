// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Order_user extends StatelessWidget {
  final List<String> orderList = ["Order 1", "Order 2", "Order 3", "Order 4"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'My Order',
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {},
              child: Ink(
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
                ),
                child: SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      orderList[index],
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.shop),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.description),
              onPressed: () {},
            ),
          ],
        ),
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        elevation: 4.0,
      ),
    );
  }
}
