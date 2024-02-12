// ignore_for_file: non_constant_identifier_names, unused_element, prefer_const_constructors, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously, unused_field, no_leading_underscores_for_local_identifiers, avoid_print
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  final String productType;
  const AddProduct({Key? key, required this.productType}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  void initState() {
    super.initState();
    print('Product Type: ${widget.productType}');
  }

  final TextEditingController _ProductIDController = TextEditingController();
  final TextEditingController _ProductNameController = TextEditingController();
  final TextEditingController _DetailController = TextEditingController();
  final TextEditingController _SizeController = TextEditingController();
  final TextEditingController _WeightController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _UnitController = TextEditingController();
  File? _imageUrl;

  final CollectionReference _AddProduct =
      FirebaseFirestore.instance.collection('Addproduct');
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    TextField(
                      controller: _ProductIDController,
                      decoration: const InputDecoration(
                          labelText: "Product ID", hintText: "Add Product ID"),
                    ),
                    TextField(
                      controller: _ProductNameController,
                      decoration: const InputDecoration(
                          labelText: "Product Name",
                          hintText: "Add Product Name"),
                    ),
                    TextField(
                      controller: _SizeController,
                      decoration: const InputDecoration(
                          labelText: "Size", hintText: "Size"),
                    ),
                    TextField(
                      controller: _WeightController,
                      decoration: const InputDecoration(
                          labelText: "Weight", hintText: "Weight"),
                    ),
                    TextField(
                      controller: _PriceController,
                      decoration: const InputDecoration(
                          labelText: "Price", hintText: "Price"),
                    ),
                    TextField(
                      controller: _UnitController,
                      decoration: const InputDecoration(
                          labelText: "Unit", hintText: "Unit"),
                    ),
                    TextField(
                      controller: _DetailController,
                      decoration: const InputDecoration(
                          labelText: "Detail", hintText: "Detail"),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Upload Image"),
                    IconButton(
                      onPressed: () async {
                        final file = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (file == null) return;
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        setState(() {
                          _imageUrl = File(file.path);
                        });
                      },
                      icon: const Icon(Icons.camera_alt),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Retrieve data from text fields
                    final String ProductID = _ProductIDController.text;
                    final String ProductName = _ProductNameController.text;
                    final String Size = _SizeController.text;
                    final String Weight = _WeightController.text;
                    final String Price = _PriceController.text;
                    final String Unit = _UnitController.text;
                    final String Detail = _DetailController.text;
                    String imageUrl = '';
                    if (_imageUrl != null) {
                      final firebase_storage.Reference ref = firebase_storage
                          .FirebaseStorage.instance
                          .ref()
                          .child('product_images')
                          .child(
                              '${DateTime.now().millisecondsSinceEpoch}.jpg');
                      await ref.putFile(_imageUrl!);
                      imageUrl = await ref.getDownloadURL();
                    }

                    if (ProductID != null) {
                      await _AddProduct.doc(documentSnapshot?.id).set({
                        "ProductID": ProductID,
                        "ProductName": ProductName,
                        "Size": Size,
                        "Weight": Weight,
                        "Price": Price,
                        "Unit": Unit,
                        "Detail": Detail,
                        "ImageUrl": imageUrl,
                        "productType": widget.productType,
                      });

                      // Clear text fields
                      _ProductIDController.text = '';
                      _ProductNameController.text = '';
                      _SizeController.text = '';
                      _WeightController.text = '';
                      _PriceController.text = '';
                      _UnitController.text = '';
                      _DetailController.text = '';
                      setState(() {
                        _imageUrl = null;
                      });
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          );
        });
  }

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _ProductIDController.text = documentSnapshot['ProductID'];
      _ProductNameController.text = documentSnapshot['ProductName'];
      _SizeController.text = documentSnapshot['Size'];
      _WeightController.text = documentSnapshot['Weight'];
      _PriceController.text = documentSnapshot['Price'];
      _UnitController.text = documentSnapshot['Unit'];
      _DetailController.text = documentSnapshot['Detail'];
    }
    File? _imageFile;
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                right: 20,
                left: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    "Update",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  children: [
                    TextField(
                      controller: _ProductIDController,
                      decoration: const InputDecoration(
                          labelText: "Product ID", hintText: "Add Product ID"),
                    ),
                    TextField(
                      controller: _ProductNameController,
                      decoration: const InputDecoration(
                          labelText: "Product Name",
                          hintText: "Add Product Name"),
                    ),
                    TextField(
                      controller: _SizeController,
                      decoration: const InputDecoration(
                          labelText: "Size", hintText: "Size"),
                    ),
                    TextField(
                      controller: _WeightController,
                      decoration: const InputDecoration(
                          labelText: "Weight", hintText: "Weight"),
                    ),
                    TextField(
                      controller: _PriceController,
                      decoration: const InputDecoration(
                          labelText: "Price", hintText: "Price"),
                    ),
                    TextField(
                      controller: _UnitController,
                      decoration: const InputDecoration(
                          labelText: "Unit", hintText: "Unit"),
                    ),
                    TextField(
                      controller: _DetailController,
                      decoration: const InputDecoration(
                          labelText: "Detail", hintText: "Detail"),
                    ),
                    IconButton(
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile == null) return;
                          String fileName =
                              DateTime.now().microsecondsSinceEpoch.toString();

                          setState(() {
                            _imageFile = File(pickedFile.path);
                          });
                        },
                        icon: const Icon(Icons.camera_alt)),
                    if (_imageFile != null) Image.file(_imageFile!),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String ProductID = _ProductIDController.text;
                      final String ProductName = _ProductNameController.text;
                      final String Size = _SizeController.text;
                      final String Weight = _WeightController.text;
                      final String Price = _PriceController.text;
                      final String Unit = _UnitController.text;
                      final String Detail = _DetailController.text;
                      if (ProductID.isNotEmpty) {
                        // Upload image if available
                        String imageUrl = '';
                        if (documentSnapshot != null) {
                          imageUrl = documentSnapshot['ImageUrl'] ?? '';
                        }
                        if (_imageFile != null) {
                          final ref = firebase_storage.FirebaseStorage.instance
                              .ref()
                              .child('product_images')
                              .child(
                                  '${DateTime.now().millisecondsSinceEpoch}.jpg');
                          await ref.putFile(_imageFile!);
                          imageUrl = await ref.getDownloadURL();
                        }

                        await _AddProduct.doc(documentSnapshot!.id).update({
                          "ProductID": ProductID,
                          "ProductName": ProductName,
                          "Size": Size,
                          "Weight": Weight,
                          "Price": Price,
                          "Unit": Unit,
                          "Detail": Detail,
                          "ImageUrl": imageUrl,
                        });
                        _ProductIDController.text = '';
                        _ProductNameController.text = '';
                        _SizeController.text = '';
                        _WeightController.text = '';
                        _PriceController.text = '';
                        _UnitController.text = '';
                        _DetailController.text = '';
                        setState(() {
                          _imageFile = null;
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }

  Future<void> _delete(String TypeID) async {
    await _AddProduct.doc(TypeID).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully delete a type")));
  }

  late Stream<QuerySnapshot> _stream;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productType),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream:
              _AddProduct.where('productType', isEqualTo: widget.productType)
                  .snapshots(),
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
                            SizedBox(
                              height: 10,
                            ),
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
                        width: 100,
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () => _update(documentSnapshot),
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () => _delete(documentSnapshot.id),
                                icon: const Icon(Icons.delete)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: const Color.fromARGB(255, 88, 136, 190),
        child: const Icon(Icons.add),
      ),
    );
  }
}
