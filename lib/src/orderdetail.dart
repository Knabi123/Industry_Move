// ignore_for_file: prefer_const_constructors, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orderdetail extends StatefulWidget {
  const Orderdetail({Key? key}) : super(key: key);

  @override
  State<Orderdetail> createState() => _MyOrderState();
}

class _MyOrderState extends State<Orderdetail> {
  late Stream<QuerySnapshot> _orderStream;

  @override
  void initState() {
    super.initState();
    _orderStream = FirebaseFirestore.instance.collection('Order').snapshots();
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
            var orderData = snapshot.data!.docs.first;

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
                SizedBox(height: 30),
                Text(
                  'ผู้สั่งสินค้า : ${orderData['Username']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Address',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  '${orderData['Location']}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      primary: Colors.redAccent,
                      onPrimary: Colors.black),
                  onPressed: () {},
                  child: Text(
                    'Payment',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(300, 40))),
                  label: Text('${orderData['Slip']}'),
                  icon: Icon(Icons.image),
                  onPressed: () {},
                ),
                SizedBox(height: 15),
                Text(
                  'วันที่ลูกค้าต้องการให้จัดส่ง : ${orderData['Time']}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'สถานะออเดอร์',
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
