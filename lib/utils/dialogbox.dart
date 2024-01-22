// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, sized_box_for_whitespace, prefer_const_constructors

import 'package:company/utils/bottondialog.dart';
import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  Dialogbox(
      {super.key,
      required this.controller,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 150,
        child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
              Text(
        "Type Name",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 8),
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: "Add New Type"),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bottondialog(text: "Cancel", onPressed: onCancel),
              const SizedBox(width: 100),
              Bottondialog(text: "Add", onPressed: onSave)
            ],
          )
        ]),
      ),
    );
  }
}