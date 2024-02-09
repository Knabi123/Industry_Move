// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class BuyProduct extends StatefulWidget {
  const BuyProduct({super.key});

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  // int selectedNumber = 1;
  final CollectionReference _AddProduct =
      FirebaseFirestore.instance.collection('Addproduct');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
         actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          
          stream: _AddProduct.snapshots(),
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
                    child: ListTile(
                      title: Text(
                        documentSnapshot['ProductID'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
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
                width: 50, // Adjust width as needed
                height: 50, // Adjust height as needed
                fit: BoxFit.cover, // Adjust image fit as needed
              ),
              SizedBox(height: 10,),
                            Row(
                              children: [
                                Text("Brand:   "),
                                Text(documentSnapshot['ProductName']),
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
                          ]),
                           trailing: SizedBox(
                         width: 150,
                        child: Row(
                          children: [
              
                        
                            ElevatedButton(onPressed: (){}, 
                            child: Text("Add to Cart"))
                          
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
            
          }),
    );
  }
}