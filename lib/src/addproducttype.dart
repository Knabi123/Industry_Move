// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:company/utils/addtype.dart';
import 'package:company/utils/dialogbox.dart';
import 'package:flutter/material.dart';

final _controller = TextEditingController();
List addtype = [
  // ["Fan",false],
  // ["Air",false],
];

class Addproducttype extends StatefulWidget {
  const Addproducttype({Key? key}) : super(key: key);

  @override
  _AddproducttypeState createState() => _AddproducttypeState();
}

class _AddproducttypeState extends State<Addproducttype> {
  void savetype() {
    setState(() {
      addtype.add([_controller.text, false]);
    });
    Navigator.of(context).pop(); // Close the dialog
  }

  void createtype(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogbox(
          controller: _controller,
          onSave: () {
            savetype();
            _controller.text = '';
          },
          onCancel: () {
            _controller.text = '';
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
         centerTitle: true, // ตำแหน่งของ title อยู่ตรงกลาง
        elevation: 2,
        
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createtype(context),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: addtype.length,
        itemBuilder: (context, index) {
          return AddType(taskname: addtype[index][0]);
        },
      ),
    );
  }
}
