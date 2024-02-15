// ignore_for_file: camel_case_types, file_names, prefer_const_constructors, non_constant_identifier_names, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'buyproduct.dart';
import 'cart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'CartController.dart';

class Type_User extends StatefulWidget {
  const Type_User({Key? key});

  @override
  State<Type_User> createState() => _Type_UserState();
}

class _Type_UserState extends State<Type_User> {
  final CollectionReference _Addtype =
      FirebaseFirestore.instance.collection('Addtype');

  @override
  Widget build(BuildContext context) {
    CartController cartController = Get.put(CartController()); 

    return GetMaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        body: StreamBuilder(
          stream: _Addtype.snapshots(),
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
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BuyProduct(
                              productType: documentSnapshot['Type'],
                            ),
                          ),
                        );
                      },
                      child: ListTile(
                        title: Text(
                          documentSnapshot['Type'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
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
      ),
    );
  }
}
