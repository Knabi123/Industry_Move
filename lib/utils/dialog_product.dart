// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:company/utils/bottonproduct.dart';
import 'package:flutter/material.dart';

class Dialogboxproduct extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController detailController = TextEditingController();

  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogboxproduct({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: idController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add ID Product",
              ),
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Name Product",
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Price",
              ),
            ),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Weight",
              ),
            ),
            TextField(
              controller: sizeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Size",
              ),
            ),
            TextField(
              controller: unitController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Unit",
              ),
            ),
            TextField(
              controller: detailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add Detail",
              ),
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
            ),
          ],
        ),
      ),
    );
  }
}
