// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, no_logic_in_create_state
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Orderdetail extends StatefulWidget {
  final DocumentSnapshot orderData;
  const Orderdetail({Key? key, required this.orderData}) : super(key: key);

  @override
  State<Orderdetail> createState() => _MyOrderState(orderData: orderData);
}

class _MyOrderState extends State<Orderdetail> {
  late Stream<QuerySnapshot> _orderStream;
  final DocumentSnapshot orderData;
//   Future<String> getImageURL(String imageName) async {
//   try {
//     // ดึง URL ของรูปภาพจาก Firebase Storage
//     String imageURL = await FirebaseStorage.instance
//         .ref()
//         .child('path/to/Slip/$imageName')
//         .getDownloadURL();

//     return imageURL;
//   } catch (e) {
//     print('Error getting image URL: $e');
//     return ''; // หรือคืนค่าอื่นที่คุณต้องการให้เหมาะสม
//   }
// }
  _MyOrderState({required this.orderData});
  @override
  void initState() {
    super.initState();
    _orderStream = FirebaseFirestore.instance.collection('Order').snapshots();
  }

  void _showImagePopup(BuildContext context, String imageURL) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Slip'),
            ),
            body: Center(
              child: Image.network(imageURL),
            ),
          );
        },
      ),
    );
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
                    minimumSize: MaterialStateProperty.all(Size(300, 40)),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (orderData['Slip'] != '') {
                        return Color.fromARGB(
                            255, 255, 255, 255); // ถ้ามี 'Slip' ให้ใช้สีขาว
                      } else {
                        return Colors.redAccent; // ถ้าไม่มี 'Slip' ให้ใช้สีแดง
                      }
                    }),
                    // Add padding to the button's icon
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 10)),
                  ),
                  label: orderData['Slip'] != ''
                      ? Text('Click to view payment')
                      : Text('No Payment'), // ปรับแสดงข้อความของปุ่ม
                  icon: Icon(Icons.image),
                  onPressed: orderData['Slip'] != ''
                      ? () async {
                          String imageURL = await orderData['Slip'];
                          _showImagePopup(context, imageURL);
                        }
                      : null, // ปรับให้ปุ่มไม่สามารถกดได้เมื่อไม่มี 'Slip'
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
