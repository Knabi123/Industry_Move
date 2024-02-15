// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, prefer_const_constructors_in_immutables, library_private_types_in_public_api, unused_import
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  CartController cartController = Get.find(); // เพิ่มบรรทัดนี้

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
                        SizedBox(
                          height: 10,
                        ),
                        if (documentSnapshot['ImageUrl'] != null)
                          Image.network(
                            documentSnapshot['ImageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text("Brand:   "),
                            Text(documentSnapshot['ProductName'] ??
                                'N/A'), // ใส่ค่าเริ่มต้น 'N/A' ถ้ามีค่าเป็น null
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Detail:"),
                        Text(documentSnapshot['Detail']),
                        SizedBox(
                          height: 10,
                        ),
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
                        SizedBox(
                          height: 10,
                        ),
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
                      child: Row(
                        children: [
                          ElevatedButton(
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
                        ],
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

class CartController {
  get cartItems => null;
}

class ShoppingCart extends StatefulWidget {
  final List<CartItem> cartItems;

  ShoppingCart({required this.cartItems});

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart"),
      ),
      body: ListView.builder(
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
                          // ถ้าปริมาณเป็น 0 ให้ลบออกจากตะกร้า
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
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total: ${calculateTotalPrice()}"),
              ElevatedButton(
                onPressed: () {
                  // สามารถทำการชำระเงินหรือกระบวนการอื่นๆตามต้องการได้ที่นี่
                },
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0.0;
    for (var cartItem in widget.cartItems) {
      total += cartItem.price * cartItem.quantity;
    }
    return total;
  }
}
