// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, prefer_const_constructors, avoid_print, no_logic_in_create_state, non_constant_identifier_names
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderDetailPage extends StatefulWidget {
  final DocumentSnapshot orderData;
  const OrderDetailPage({Key? key, required this.orderData}) : super(key: key);
  @override
  State<OrderDetailPage> createState() => _MyOrderState(orderData: orderData);
}

class _MyOrderState extends State<OrderDetailPage> {
  late Stream<QuerySnapshot> _orderStream;
  late File _imageFile;
  final DocumentSnapshot orderData;
  _MyOrderState({required this.orderData});
  @override
  void initState() {
    super.initState();
    _orderStream = FirebaseFirestore.instance.collection('Order').snapshots();
  }

  Future<void> _uploadImage([DocumentSnapshot? documentSnapshot]) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      // Upload image to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('Slip/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_imageFile);

      // Get the download URL
      final Slip = await storageRef.getDownloadURL();

      // Update Firestore document with the image URL
      await FirebaseFirestore.instance
          .collection('Order')
          .doc('Fc4ynHcHzsQavBjPGm86')
          .update({
        'Slip': Slip,
      });
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
        title: Text('Order'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _orderStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            // Assuming you have only one document in the 'Order' collection
            var orderData = widget.orderData;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 120.0),
                  child: Text(
                    'Order Detail',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'รหัสออเดอร์ : ${orderData['OrderID']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'รหัสสินค้า : ${orderData['ProductID']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Text(
                      'ยี่ห้อ : ${orderData['ProductName']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '  จำนวน : ${orderData['Amount']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '  ตัว',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '  ราคา : ${orderData['Price']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      '  บาท',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'ผู้สั่งสินค้า : ${orderData['Username']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  '${orderData['Location']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'หลักฐานการชำระเงิน',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Center(
                    child: Image.asset(
                  'assets/images/qrcode.png',
                  height: 200,
                )),
                SizedBox(height: 10),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(300, 40))),
                    label: Text('slip'),
                    icon: Icon(Icons.image),
                    onPressed: _uploadImage,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  'วันที่ต้องการให้จัดส่ง : ${orderData['Time']}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Status Order: ${orderData['status']}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                        color: Colors.deepOrangeAccent),
                  ),
                )
              ],
            );
          },
        ),
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}
