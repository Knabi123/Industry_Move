// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Order').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        var orders = snapshot.data!.docs;

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            var order = orders[index].data() as Map<String, dynamic>;

            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: ListTile(
                title: Text(
                  'OrderID: ${order['OrderID'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 18, // ตั้งค่าขนาดตัวอักษร OrderID
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold, // ตั้งค่าสีของตัวอักษร
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ProductName: ${order['ProductName'] ?? ''}'),
                    Text('Username: ${order['Username'] ?? ''}'),
                    Text('Location: ${order['Location'] ?? ''}'),
                    Text('Time: ${order['Time'] ?? ''}'),
                    Text('Amount: ${order['Amount'] ?? 0}'),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
