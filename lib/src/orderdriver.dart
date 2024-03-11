// ignore_for_file: use_key_in_widget_constructors, unused_import

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:company/src/orderlist.dart';
import 'package:company/src_user/login.dart';
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

        if (!snapshot.hasData) {
          return Text('Loading...');
        }

        final List<DocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final orderData = documents[index].data() as Map<String, dynamic>;
            final orderId = documents[index].id;

            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OrderID: ${orderData['OrderID']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('ชื่อสินค้า: ${orderData['ProductName']}'),
                    Text('สถานที่ส่ง: ${orderData['Location']}'),
                    Text('ราคา: ${orderData['Price']}'),
                    Text('จํานวณ: ${orderData['Amount']}'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    print('เสร็จ สำหรับ Order ID: $orderId');
                  },
                  child: Text('เสร็จ'),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

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
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
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
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text(
                  'ออกจากระบบ',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
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
