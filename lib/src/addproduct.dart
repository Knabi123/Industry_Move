// ignore_for_file: non_constant_identifier_names, unused_element, prefer_const_constructors, unused_local_variable, unnecessary_null_comparison, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _ProductIDController = TextEditingController();
  final TextEditingController _ProductNameController = TextEditingController();
  final TextEditingController _DetailController = TextEditingController();
  final TextEditingController _SizeController = TextEditingController();
  final TextEditingController _WeightController = TextEditingController();
  final TextEditingController _PriceController = TextEditingController();
  final TextEditingController _UnitController = TextEditingController();

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
                        },
                        icon: const Icon(Icons.camera_alt)),
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

                      if (ProductID != null) {
                        await _AddProduct.add({
                          "ProductID": ProductID,
                          "ProductName": ProductName,
                          "Size": Size,
                          "Weight": Weight,
                          "Price": Price,
                          "Unit": Unit,
                          "Detail": Detail,
                        });
                        _ProductIDController.text = '';
                        _ProductNameController.text = '';
                        _SizeController.text = '';
                        _WeightController.text = '';
                        _PriceController.text = '';
                        _UnitController.text = '';
                        _DetailController.text = '';

                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text("Create"))
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
                          final file = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (file == null) return;
                        },
                        icon: const Icon(Icons.camera_alt)),
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
                      if (ProductID != null) {
                        await _AddProduct.doc(documentSnapshot!.id).update({
                          "ProductID": ProductID,
                          "ProductName": ProductName,
                          "Size": Size,
                          "Weight": Weight,
                          "Price": Price,
                          "Unit": Unit,
                          "Detail": Detail,
                        });
                        _ProductIDController.text = '';
                        _ProductNameController.text = '';
                        _SizeController.text = '';
                        _WeightController.text = '';
                        _PriceController.text = '';
                        _UnitController.text = '';
                        _DetailController.text = '';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: StreamBuilder(
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
