// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, library_private_types_in_public_api, prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AddDriverDialog extends StatefulWidget {
  final Function(DriverInfo) onDriverAdded;

  AddDriverDialog({required this.onDriverAdded});

  @override
  _AddDriverDialogState createState() => _AddDriverDialogState();
}

class _AddDriverDialogState extends State<AddDriverDialog> {
  File? _image;
  String? _driverId;
  String? _driverPassword;
  String? _driverName;
  String? _carId;
  String? _licenseId;

  Future<void> _getImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Driver'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) => _driverId = value,
              decoration: InputDecoration(
                labelText: 'Driver ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) => _driverPassword = value,
              decoration: InputDecoration(
                labelText: 'Driver Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) => _driverName = value,
              decoration: InputDecoration(
                labelText: 'Driver Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) => _carId = value,
              decoration: InputDecoration(
                labelText: 'Car ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              onChanged: (value) => _licenseId = value,
              decoration: InputDecoration(
                labelText: 'License ID',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            TextButton(
              onPressed: () async {
                await _getImage(context);
                if (_image != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Image selected: ${basename(_image!.path)}'),
                    ),
                  );
                }
              },
              child: Container(
                height: 100.0,
                width: 400.0,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: _image == null
                    ? Center(
                        child: Text('Add Image'),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(basename(_image!.path)),
                          SizedBox(height: 8.0),
                          Image.file(_image!),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onDriverAdded(DriverInfo(
              driverId: _driverId,
              driverPassword: _driverPassword,
              driverName: _driverName,
              carId: _carId,
              licenseId: _licenseId,
              image: _image,
            ));
            Navigator.pop(context);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

class DriverInfo {
  final String? driverId;
  final String? driverPassword;
  final String? driverName;
  final String? carId;
  final String? licenseId;
  final File? image;

  DriverInfo({
    required this.driverId,
    required this.driverPassword,
    required this.driverName,
    required this.carId,
    required this.licenseId,
    required this.image,
  });
}
