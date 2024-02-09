// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, non_constant_identifier_names, use_build_context_synchronously, file_names, camel_case_types, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/src/addproduct.dart';
import 'package:flutter/material.dart';

class Add_Pro extends StatefulWidget {
  const Add_Pro({super.key});

  @override
  State<Add_Pro> createState() => _Add_ProState();
}

class _Add_ProState extends State<Add_Pro> {
  final TextEditingController _TypeController = TextEditingController();
  final CollectionReference _Addtype =
      FirebaseFirestore.instance.collection('Addtype');
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
                    "Add Type",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                TextField(
                  controller: _TypeController,
                  decoration: const InputDecoration(
                      labelText: "Type", hintText: "Add Type"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String Type = _TypeController.text;
                      if (Type != null) {
                        await _Addtype.add({"Type": Type});
                        _TypeController.text = '';

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
      _TypeController.text = documentSnapshot['Type'];
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
                TextField(
                  controller: _TypeController,
                  decoration: const InputDecoration(
                      labelText: "Type", hintText: "Add Type"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () async {
                      final String Type = _TypeController.text;
                      if (Type != null) {
                        await _Addtype.doc(documentSnapshot!.id)
                            .update({"Type": Type});
                        _TypeController.text = '';

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
    await _Addtype.doc(TypeID).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You have successfully delete a type")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Home",
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
      ),
      body: StreamBuilder(
          stream: _Addtype.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (Context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                  return Card(
                      color: Colors.deepPurple[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddProduct()), // สมมติว่าหน้า AddProduct มีชื่อว่า AddProduct
                          );
                        },
                        child: ListTile(
                          title: Text(
                            documentSnapshot['Type'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: () => _update(documentSnapshot),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                    onPressed: () =>
                                        _delete(documentSnapshot.id),
                                    icon: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        backgroundColor: Colors.deepPurple[400],
        child: const Icon(Icons.add),
      ),
    );
  }
}
