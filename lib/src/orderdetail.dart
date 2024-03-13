// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_build_context_synchronously, no_logic_in_create_state, avoid_print, unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/src/bottombar.dart';
import 'package:company/src/orderscreen.dart';
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
        title: Text('Order Detail'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
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
            bool hasSlip = orderData['Slip'] != '';
            bool isFinished = orderData['status'] == 'Finished';
            bool isCurrentlyShipping =
                orderData['status'] == 'Currently shipping';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                        return Color.fromARGB(255, 255, 255, 255);
                      } else {
                        return Colors.redAccent;
                      }
                    }),
                    // Add padding to the button's icon
                    padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(horizontal: 10)),
                  ),
                  label: orderData['Slip'] != ''
                      ? Text('Click to view payment')
                      : Text('No Payment'),
                  icon: Icon(Icons.image),
                  onPressed: orderData['Slip'] != ''
                      ? () async {
                          String imageURL = await orderData['Slip'];
                          _showImagePopup(context, imageURL);
                        }
                      : null,
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
                ),
                SizedBox(height: 30),
                Expanded(
                    child: Center(
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(300, 60)),
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (!hasSlip) {
                            return const Color.fromARGB(255, 254, 0, 0);
                          } else if (isFinished || isCurrentlyShipping) {
                            return Color.fromARGB(202, 218, 214, 214);
                          } else {
                            return Color.fromARGB(255, 185, 133, 198);
                          }
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide.none, // ไม่มีเส้นขอบ
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(
                          4), // เพิ่มความสูงของปุ่ม
                      shadowColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0.8), // สีเงา
                      ),
                    ),
                    label: hasSlip
                        ? Text(
                            'Select Driver',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'No Payment',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                    icon: Icon(Icons.local_shipping),
                    onPressed: (isFinished || isCurrentlyShipping)
                        ? null
                        : (hasSlip
                            ? () => _selectDriver(context, orderData: orderData)
                            : () =>
                                _selectDriver(context, orderData: orderData)),
                  ),
                ))
              ],
            );
          },
        ),
      ),
      backgroundColor: Colors.deepPurple[100],
    );
  }
}

void _selectDriver(BuildContext context,
    {required DocumentSnapshot orderData}) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text('Select Driver')),
            elevation: 2,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(2.0),
              child: Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                height: 2.0,
              ),
            ),
          ),
          body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('drivers').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              var driverDocs = snapshot.data?.docs ?? [];
              return ListView.builder(
                itemCount: driverDocs.length,
                itemBuilder: (context, index) {
                  var driverData =
                      driverDocs[index].data() as Map<String, dynamic>;
                  var imageUrl = driverData['imageUrl'] ?? '';
                  var name = driverData['name'] ?? '';
                  var carId = driverData['carid'] ?? '';
                  var licensePlate = driverData['licensePlate'] ?? '';
                  return Card(
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 2,
                    child: ListTile(
                      leading: imageUrl.isNotEmpty
                          ? Image.network(imageUrl)
                          : Icon(Icons.person),
                      title: Text(name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Car ID: $carId'),
                          Text('License Plate: $licensePlate'),
                        ],
                      ),
                      onTap: () {
                        String driverId = driverData['driverId'];
                        _confirmDriverSelection(context, name, driverId,
                            orderData: orderData);
                      },
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    ),
  );
}

void _confirmDriverSelection(
    BuildContext context, String driverName, String driverId,
    {required DocumentSnapshot orderData}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Center(
            child: Text('Confirmation',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select $driverName as the driver to delivery Order No.${orderData['OrderID']}?',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('Order')
                  .doc(orderData.id)
                  .update({
                'status': 'Currently shipping',
                'ResponsibleDriver': driverName,
                'ResponsibleDriverId': driverId,
              }).then((_) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => BottomBar()),
                );
              }).catchError((error) {
                print('Error updating order status: $error');
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            child: Text(
              'Yes',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(
              'No',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );
    },
  );
}
