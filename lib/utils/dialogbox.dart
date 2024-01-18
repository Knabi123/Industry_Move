import 'package:company/utils/bottondialog.dart';
import 'package:flutter/material.dart';

class Dialogbox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  Dialogbox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel
    });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height:120,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add New Type"
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Bottondialog(text: "Add", onPressed: onSave),
              const SizedBox(width: 8),
              Bottondialog(text: "Cancel", onPressed: onCancel)
            ],
          )
        ]),
         ),
    );
  }
}