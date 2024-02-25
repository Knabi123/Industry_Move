// ignore_for_file: prefer_const_constructors, sort_child_properties_last, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/src/orderdetail.dart';
import 'package:company/src_user/login.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);
  final CollectionReference _Order =
      FirebaseFirestore.instance.collection('Order');
  // final List<String> orderList = ["Order 1", "Order 2", "Order 3", "Order 4"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          elevation: 0,
          title: Text(
            'My Orders',
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
        body: StreamBuilder<QuerySnapshot>(
            stream: _Order.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (Context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];

                    return Card(
                        color: const Color.fromARGB(255, 88, 136, 190),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Orderdetail(orderData: documentSnapshot)),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              documentSnapshot['OrderID'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("ProductId : "),
                                      Text(documentSnapshot['ProductID']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Productname : "),
                                      Text(documentSnapshot['ProductName']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Name : "),
                                      Text(documentSnapshot['Username']),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text("Amount : "),
                                      Text(
                                          "Amount : ${documentSnapshot['Amount'].toString()}"),
                                      Text("Price :  "),
                                      Text(
                                          "Price : ${documentSnapshot['Price'].toString()}"),
                                    ],
                                  ),
                                ]),
                          ),
                        ));
                  },
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
