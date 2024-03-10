// ignore_for_file: prefer_const_constructors, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names, prefer_const_constructors_in_immutables, unused_import, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:company/firestore_service.dart';
import 'package:company/src/Type_User.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'cart.dart';
import 'CartController.dart';
import 'package:get/get.dart';

class BuyProduct extends StatefulWidget {
  final String productType;
  const BuyProduct({Key? key, required this.productType}) : super(key: key);
  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  final CollectionReference _AddProduct =
      FirebaseFirestore.instance.collection('Addproduct');
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productType),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShoppingCart(cartItems: cartController.cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _AddProduct.where('productType', isEqualTo: widget.productType)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  color: const Color.fromARGB(255, 88, 136, 190),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      documentSnapshot['ProductID'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        if (documentSnapshot['ImageUrl'] != null)
                          Image.network(
                            documentSnapshot['ImageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text("Brand:   "),
                            Text(documentSnapshot['ProductName'] ?? 'N/A'),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text("Detail:"),
                        Text(documentSnapshot['Detail']),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text("Size: "),
                                Text(documentSnapshot['Size']),
                              ],
                            ),
                            Row(
                              children: [
                                Text("   Weight:  "),
                                Text(documentSnapshot['Weight']),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text("Price: "),
                                Text(documentSnapshot['Price']),
                              ],
                            ),
                            Row(
                              children: [
                                Text("   Unit:  "),
                                Text(documentSnapshot['Unit']),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          addToCart(
                            documentSnapshot['ProductID'],
                            documentSnapshot['ProductName'],
                            documentSnapshot['ImageUrl'],
                            documentSnapshot['Price'],
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('เพิ่มลงในตะกร้าแล้ว'),
                            ),
                          );
                        },
                        child: Text("Add to Cart"),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void addToCart(
    String productId,
    String productName,
    String imageUrl,
    String price,
  ) {
    setState(() {
      try {
        var existingItem = cartController.cartItems.firstWhere(
          (item) => item.productId == productId,
          orElse: () => CartItem(
            productId: productId,
            productName: productName,
            imageUrl: imageUrl,
            price: double.tryParse(price) ?? 0.0,
            quantity: 0,
          ),
        );

        if (existingItem.quantity == 0) {
          cartController.cartItems.add(
            CartItem(
              productId: productId,
              productName: productName,
              imageUrl: imageUrl,
              price: double.tryParse(price) ?? 0.0,
              quantity: 1,
            ),
          );
        } else {
          existingItem.quantity++;
        }
      } catch (e) {
        print("Error: $e");
      }
    });
  }
}

class ShoppingCart extends StatefulWidget {
  final List<CartItem> cartItems;
  ShoppingCart({required this.cartItems});
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  late TextEditingController addressController;
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: TextStyle(
            fontSize: 24, // ตั้งค่าขนาดตัวอักษร
            fontWeight: FontWeight.bold, // ตั้งค่าน้ำหนักตัวอักษร
            letterSpacing: 1.5, // ตั้งค่าระยะห่างระหว่างตัวอักษร
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                var cartItem = widget.cartItems[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(cartItem.productName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Quantity: ${cartItem.quantity}"),
                        Text("Price: ${cartItem.price * cartItem.quantity}"),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (cartItem.quantity > 0) {
                                cartItem.quantity--;
                              } else {
                                widget.cartItems.remove(cartItem);
                              }
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              cartItem.quantity++;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.deepPurple,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.black, // สีกรอบดำเข้ม
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.location_on_sharp,
                          color: Colors.red,
                        ),
                        filled: true,
                        fillColor: Colors.deepPurple[200],
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(
                            255, 201, 176, 230), // เปลี่ยนสีพื้นหลังของปุ่ม
                        elevation:
                            4, // เพิ่ม elevation เพื่อให้เห็นกรอบสีดำเข้มได้ชัดเจน
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            color: Colors.black, // สีกรอบดำเข้ม
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons
                                .calendar_month, // ใส่ไอคอน calendar_month ในปุ่ม
                            size: 18, // ปรับขนาดไอคอน
                          ),
                          SizedBox(
                              width: 8), // เพิ่มระยะห่างระหว่างไอคอนกับ Text
                          Text(
                            "Choose Date",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    if (selectedDate != null)
                      Text(
                        "วันที่: ${selectedDate != null ? selectedDate!.toLocal().toString().split(' ')[0] : ''}",
                        style: TextStyle(fontSize: 10),
                      ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total: ${calculateTotalPrice()}"),
                ElevatedButton(
                  onPressed: () {
                    submit();
                  },
                  child: Text("Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var cartItem in widget.cartItems) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }

  void submit() {
    CollectionReference orders = FirebaseFirestore.instance.collection('Order');
    var random = Random();
    String OrderId = '';
    DateTime now = DateTime.now();
    if (widget.cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please add at least one item to the cart.'),
          backgroundColor: Color.fromARGB(255, 106, 221, 236),
        ),
      );
      return;
    }
    if (addressController.text.isEmpty || addressController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please enter a valid address (minimum 10 characters).'),
          backgroundColor: Color.fromARGB(255, 106, 221, 236),
        ),
      );
      return;
    }
    if (selectedDate == null ||
        selectedDate!.isBefore(DateTime.now().add(Duration(days: 3)))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Please select a valid date (at least 3 days from now).'),
          backgroundColor: Color.fromARGB(202, 247, 0, 222),
        ),
      );
      return;
    }
    for (var i = 0; i < 6; i++) {
      OrderId += (random.nextInt(10)).toString();
    }
    for (var cartItem in widget.cartItems) {
      orders.add({
        'OrderID': OrderId,
        'ProductID': cartItem.productId,
        'ProductName': cartItem.productName,
        'Amount': cartItem.quantity,
        'Price': cartItem.price * cartItem.quantity,
        'Location': addressController.text, // ใช้ค่าจาก addressController
        'Time': selectedDate != null ? selectedDate!.toLocal().toString() : '',
        'Username': Provider.of<UserData>(context, listen: false).id ?? 'No ID',
        'Slip': '',
        'status': 'Waiting for payment',
        'CreateDate': now.toString(),
      }).then((value) {
        print("Order added successfully!");
      }).catchError((error) {
        print("Failed to add order: $error");
      });
    }

    widget.cartItems.clear();
    setState(() {
      Navigator.of(context).pop();
    });
  }
}
