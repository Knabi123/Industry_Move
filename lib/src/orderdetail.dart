// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';

class Orderdetail extends StatefulWidget {
  const Orderdetail({Key? key}) : super(key: key);

//App Bar

  @override
  State<Orderdetail> createState() => _MyOrderState();
}

class _MyOrderState extends State<Orderdetail> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 120.0),
              child: Text(
                'Order Detail',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'รหัสสินค้า : ??',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              'วันที่และเวลาที่สั่งออเดอร์ : ??',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 30),
            Text(
              'Address',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Text(
              '??',
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
              label: Text('image.png'),
              icon: Icon(Icons.image),
              onPressed: () {},
            ),
            SizedBox(height: 15),
            Text(
              'วันที่ลูกค้าต้องการให้จัดส่ง : ??',
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
        ),
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}
