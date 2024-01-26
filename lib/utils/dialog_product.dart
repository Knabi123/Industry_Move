// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:company/utils/bottonproduct.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Dialogboxproduct extends StatelessWidget {
  final TextEditingController idController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  VoidCallback onSave;
  VoidCallback onCancel;

  Dialogboxproduct({
    super.key,
    required this.onSave,
    required this.onCancel,
  });
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageUrlController.text = pickedFile.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 1000,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Product ID"),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Product ID",
              ),
            ),
            Text("Product Name"),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Product Name",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "Size" and "Weight" on the same line
                Text("Size"),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: sizeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Size",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text("Weight"),
                const SizedBox(
                    width: 5), // Adjust the spacing between "Size" and "Weight"
                Expanded(
                  child: TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Weight",
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // "Unit" and "Price" on the same line
                Text("Unit"),
                const SizedBox(width: 5),
                Expanded(
                  child: TextField(
                    controller: unitController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Unit",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text("Price"),
                const SizedBox(
                    width: 5), // Adjust the spacing between "Unit" and "Price"
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Price",
                    ),
                  ),
                ),
              ],
            ),
            Text("Detail"),
            TextField(
              controller: detailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Detail",
              ),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text("Select Image Product"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonProduct(text: "Cancel", onPressed: onCancel),
                const SizedBox(
                  width: 100,
                ),
                ButtonProduct(text: "Add", onPressed: onSave),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
