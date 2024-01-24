// ignore_for_file: library_private_types_in_public_api, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class OrderDetailsPage extends StatefulWidget {
  final String selectedOrder;

  const OrderDetailsPage({Key? key, required this.selectedOrder})
      : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  XFile? _selectedImage; // เก็บไฟล์รูปที่ถูกเลือก

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'รหัสออเดอร์',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            Text(
              widget.selectedOrder,
            ),
            // วันที่และเวลาส่งออเดอร์
            const SizedBox(height: 16), // ระยะห่าง
            const Text(
              'วันที่และเวลาส่งออเดอร์',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Text(
              'ยังไม่มีข้อมูล',
            ),

            const SizedBox(height: 16),
            const Text(
              'ที่อยู่',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18,
              ),
            ),
            const Text(
              'ยังไม่มีข้อมูล',
            ),
            const SizedBox(height: 16),
            const Text(
              'ORDER STATUS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 144, 0),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 18),

            const SizedBox(height: 18),
            const Text(
              'หลักฐานการชำระเงิน',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: _selectedImage != null
                    ? Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        size: 40,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
