// ignore_for_file: use_key_in_widget_constructors, unused_import, avoid_print, deprecated_member_use, duplicate_ignore

// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:company/firestore_service.dart';
import 'package:company/src_user/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Order')
          .where('ResponsibleDriverId',
              isEqualTo:
                  Provider.of<UserData>(context, listen: false).id ?? 'No ID')
          .snapshots(),
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
            bool isFinished = orderData['status'] == 'Finished';
            return Card(
              margin: EdgeInsets.all(8),
              elevation: 4, // เพิ่มความสูงของ Card
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15), // ปรับขอบมนเพื่อให้มีมิติ
                side: BorderSide(
                  color: Colors.grey, // สีขอบเส้น
                  width: 1, // ความหนาของเส้น
                ),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                    vertical: 8, horizontal: 16), // เพิ่ม padding ใน ListTile
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
                    Text('จำนวณ: ${orderData['Amount']}'),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    if (!isFinished) {
                      FirebaseFirestore.instance
                          .collection('Order')
                          .doc(orderId)
                          .update({
                        'status': 'Finished',
                      }).then((_) {
                        print(
                            'อัปเดตค่า status เป็น Finished สำเร็จสำหรับ Order ID: $orderId');
                      }).catchError((error) {
                        print('เกิดข้อผิดพลาดในการอัปเดตค่า status: $error');
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isFinished
                        ? Color.fromARGB(255, 181, 181, 181)
                        : Color.fromARGB(255, 31, 229, 1),
                  ),
                  child: Text(
                    isFinished ? 'จบงานแล้ว' : 'ส่งสินค้าสำเร็จ',
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: isFinished ? 16 : 16,
                      color: isFinished
                          ? const Color.fromARGB(255, 124, 123, 123)
                          : Colors.white,
                    ),
                  ),
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
            color: Colors.white,
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
                decoration: BoxDecoration(
                  color: Colors.deepPurple[300],
                ),
                child: Center(
                  child: Text(
                    'L O G O',
                    style: TextStyle(fontSize: 35, color: Colors.white),
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
      body: Container(
        color: const Color.fromARGB(255, 244, 244, 244),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: OrderList(),
        ),
      ),
    );
  }
}
