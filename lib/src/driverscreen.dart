// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DriverDetailPage extends StatefulWidget {
  @override
  _DriverDetailPageState createState() => _DriverDetailPageState();
}

class _DriverDetailPageState extends State<DriverDetailPage> {
  List<Driver> drivers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver'),
        centerTitle: true,
        backgroundColor: Color(0xFF864AF9),
        elevation: 2.0,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddDialog();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              for (Driver driver in drivers)
                Card(
                  elevation: 3.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Driver Name: ${driver.name}'),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _showEditDialog(driver);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    _deleteDriver(driver);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text('Car ID: ${driver.carid}'),
                        Text('License ID: ${driver.licensePlate}'),
                        if (shouldShowDriverDetails(driver))
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Driver ID: ${driver.driverId}'),
                              Text('Driver Password: ${driver.driverPassword}'),
                            ],
                          ),
                        if (driver.imageUrl != null)
                          Container(
                            width: 250.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.file(
                                File(driver.imageUrl!),
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  bool shouldShowDriverDetails(Driver driver) {
    return false;
  }

  void _showAddDialog() async {
    String name = '';
    String licensePlate = '';
    String carid = '';
    String driverId = '';
    String driverPassword = '';
    String? imageUrl;

    final picker = ImagePicker();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            'Add Driver',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Driver Name', (value) {
                  name = value;
                }),
                _buildTextField('Car ID', (value) {
                  carid = value;
                }),
                _buildTextField('License ID', (value) {
                  licensePlate = value;
                }),
                _buildTextField('Driver ID', (value) {
                  driverId = value;
                }),
                _buildTextField('Driver Password', (value) {
                  driverPassword = value;
                }),
                SizedBox(height: 20),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      setState(() {
                        imageUrl = pickedFile.path;
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue),
                      color: imageUrl != null ? Colors.green : Colors.grey,
                    ),
                    child: Center(
                      child: imageUrl != null
                          ? Image.file(
                              File(imageUrl!),
                              width: double.infinity,
                              height: 40.0,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            _buildDialogButton('Cancel', () {
              Navigator.pop(context);
            }),
            _buildDialogButton('Add', () {
              setState(() {
                drivers.add(Driver(
                  name: name,
                  carid: carid,
                  licensePlate: licensePlate,
                  imageUrl: imageUrl,
                  driverId: driverId,
                  driverPassword: driverPassword,
                ));
              });
              Navigator.pop(context);
            }),
          ],
        );
      },
    );
  }

  void _showEditDialog(Driver driver) async {
    String name = driver.name;
    String licensePlate = driver.licensePlate;
    String carid = driver.carid;
    String driverId = driver.driverId;
    String driverPassword = driver.driverPassword;
    String? imageUrl = driver.imageUrl;

    final picker = ImagePicker();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: Text(
            'Edit Driver',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField('Driver Name', (value) {
                  name = value;
                }, initialValue: name),
                _buildTextField('Car ID', (value) {
                  carid = value;
                }, initialValue: carid),
                _buildTextField('License ID', (value) {
                  licensePlate = value;
                }, initialValue: licensePlate),
                _buildTextField('Driver ID', (value) {
                  driverId = value;
                }, initialValue: driverId),
                _buildTextField('Driver Password', (value) {
                  driverPassword = value;
                }, initialValue: driverPassword),
                SizedBox(height: 20),
                InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () async {
                    final pickedFile =
                        await picker.pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      setState(() {
                        imageUrl = pickedFile.path;
                      });
                    }
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue),
                      color: imageUrl != null ? Colors.green : Colors.grey,
                    ),
                    child: Center(
                      child: imageUrl != null
                          ? Image.file(
                              File(imageUrl!),
                              width: double.infinity,
                              height: 40.0,
                              fit: BoxFit.cover,
                            )
                          : Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            _buildDialogButton('Cancel', () {
              Navigator.pop(context);
            }),
            _buildDialogButton('Save', () {
              setState(() {
                driver.name = name;
                driver.carid = carid;
                driver.licensePlate = licensePlate;
                driver.imageUrl = imageUrl;
                driver.driverId = driverId;
                driver.driverPassword = driverPassword;
              });
              Navigator.pop(context);
            }),
          ],
        );
      },
    );
  }

  void _deleteDriver(Driver driver) {
    setState(() {
      drivers.remove(driver);
    });
  }

  Widget _buildTextField(
    String labelText,
    Function(String) onChanged, {
    String? initialValue,
  }) {
    TextEditingController controller =
        TextEditingController(text: initialValue);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        key: ValueKey(labelText),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 14.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }

  Widget _buildDialogButton(String text, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class Driver {
  String name;
  String licensePlate;
  String carid;
  String driverId;
  String driverPassword;
  String? imageUrl;

  Driver({
    required this.name,
    required this.licensePlate,
    required this.carid,
    required this.driverId,
    required this.driverPassword,
    this.imageUrl,
  });
}
