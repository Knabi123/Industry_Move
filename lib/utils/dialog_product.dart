// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:company/utils/bottonproduct.dart';
import 'package:flutter/material.dart';

class Dialogboxproduct extends StatelessWidget {
  final controllerproduct;
  VoidCallback onSave;
  VoidCallback onCancel;
  Dialogboxproduct({
    super.key,
    required this.controllerproduct,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 1000,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add ID Product"),
          ),
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add Name Product"),
          ),
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add Price"),
          ),
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add Weight"),
          ),
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add Size"),
          ),
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add Unit"),
          ),
          TextField(
            controller: controllerproduct,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add Detail"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ButtonProduct(text: "Add", onPressed: onSave),
              const SizedBox(
                width: 4,
              ),
              ButtonProduct(text: "Cancel", onPressed: onCancel),
            ],
          )
        ]),
      ),
    );
  }
}
