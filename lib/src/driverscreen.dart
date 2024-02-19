// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, avoid_print, use_build_context_synchronously, avoid_function_literals_in_foreach_calls

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DriverDetailPage extends StatefulWidget {
  @override
  _DriverDetailPageState createState() => _DriverDetailPageState();
}

class _DriverDetailPageState extends State<DriverDetailPage> {
  List<Driver> drivers = [];
  File? _imageFile;

  Future<void> _getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImageToFirebaseStorage(File imageFile) async {
    try {
      TaskSnapshot task = await FirebaseStorage.instance
          .ref('images/${DateTime.now().toString()}')
          .putFile(imageFile);

      String imageUrl = await task.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Widget _buildDriverCard(Driver driver) {
    return Card(
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
            _buildDriverImage(driver.imageUrl),
          ],
        ),
      ),
    );
  }

  Widget _buildDriverImage(String imageUrl) {
    return imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          )
        : Container();
  }

  Widget _buildImageField({String? initialValue}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: _getImage,
            child: Text('Select Image'),
          ),
          if (_imageFile != null)
            Image.file(
              _imageFile!,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          if (_imageFile != null || initialValue != null)
            _buildDriverImage(_imageFile?.path ?? initialValue ?? ''),
        ],
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

    await showDialog(
      context: context,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 400.0),
          child: AlertDialog(
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
                  _buildImageField(),
                ],
              ),
            ),
            actions: [
              _buildDialogButton('Cancel', () {
                if (mounted) {
                  setState(() {
                    _imageFile = null;
                  });
                }
                Navigator.pop(context);
              }),
              _buildDialogButton('Add', () async {
                if (_imageFile != null) {
                  String imageUrl =
                      await _uploadImageToFirebaseStorage(_imageFile!);
                  await _addDriverToFirestore(name, carid, licensePlate,
                      driverId, driverPassword, imageUrl);
                  setState(() {
                    _imageFile = null;
                  });
                  Navigator.pop(context);
                } else {}
              }),
            ],
          ),
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

    await showDialog(
      context: context,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 400.0),
          child: AlertDialog(
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
                  _buildImageField(initialValue: driver.imageUrl),
                ],
              ),
            ),
            actions: [
              _buildDialogButton('Cancel', () {
                Navigator.pop(context);
              }),
              _buildDialogButton('Save', () async {
                if (_imageFile != null) {
                  String imageUrl =
                      await _uploadImageToFirebaseStorage(_imageFile!);
                  await _updateDriverInFirestore(driver, name, carid,
                      licensePlate, driverId, driverPassword, imageUrl);
                  if (mounted) {
                    setState(() {
                      _imageFile = null;
                    });
                    Navigator.pop(context);
                  }
                } else {
                  await _updateDriverInFirestore(driver, name, carid,
                      licensePlate, driverId, driverPassword, driver.imageUrl);
                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              }),
            ],
          ),
        );
      },
    );
  }

  void _deleteDriver(Driver driver) {
    _deleteDriverFromFirestore(driver);
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

  Future<bool> _checkUserIdExists(String id) async {
    // Check if id exists in User collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('User')
        .where('id', isEqualTo: id)
        .get();

    // If querySnapshot has data, then id exists
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> _addDriverToFirestore(
      String name,
      String carid,
      String licensePlate,
      String driverId,
      String driverPassword,
      String imageUrl) async {
    // Check if all fields are filled correctly
    if (name.isNotEmpty &&
        carid.isNotEmpty &&
        carid.length <= 8 &&
        licensePlate.isNotEmpty &&
        licensePlate.length <= 8 &&
        driverId.isNotEmpty &&
        driverPassword.isNotEmpty &&
        driverPassword.length >= 8) {
      // Check if driverId exists in database
      bool driverExists = await _checkDriverExists(driverId);

      // Check if id exists in User collection
      bool idExists = await _checkUserIdExists(driverId);

      if (!driverExists && !idExists) {
        // If driverId does not exist and id does not exist, add driver to Firestore
        await FirebaseFirestore.instance.collection('drivers').add({
          'name': name,
          'carid': carid,
          'licensePlate': licensePlate,
          'driverId': driverId,
          'driverPassword': driverPassword,
          'imageUrl': imageUrl,
        });

        // Also add driver information to User collection
        await FirebaseFirestore.instance.collection('User').add({
          'id': driverId,
          'password': driverPassword,
          'name': name,
          'role': 'Driver',
        });
      } else {
        // If driverId or id already exists, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Driver ID or ID already exists. Please choose another one.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // If any field is not filled correctly, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<bool> _checkDriverExists(String driverId) async {
    // Check if driverId exists in database
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('drivers')
        .where('driverId', isEqualTo: driverId)
        .get();

    // If querySnapshot has data, then driverId exists
    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> _updateDriverInFirestore(
      Driver driver,
      String name,
      String carid,
      String licensePlate,
      String driverId,
      String driverPassword,
      String imageUrl) async {
    // Check if all fields are filled correctly
    if (name.isNotEmpty &&
        carid.isNotEmpty &&
        carid.length <= 8 &&
        licensePlate.isNotEmpty &&
        licensePlate.length <= 8 &&
        driverId.isNotEmpty &&
        driverPassword.isNotEmpty &&
        driverPassword.length >= 8) {
      // Check if driverId exists in database
      bool driverExists = await _checkDriverExists(driverId);

      // Check if id exists in User collection
      bool idExists = await _checkUserIdExists(driverId);

      if ((!driverExists || driverId == driver.driverId) && !idExists) {
        // If driverId does not exist or is the same as before, update driver in Firestore
        await FirebaseFirestore.instance
            .collection('drivers')
            .doc(driver.id)
            .update({
          'name': name,
          'carid': carid,
          'licensePlate': licensePlate,
          'driverId': driverId,
          'driverPassword': driverPassword,
          'imageUrl': imageUrl,
        });

        // Also update driver information in User collection
        QuerySnapshot userQuerySnapshot = await FirebaseFirestore.instance
            .collection('User')
            .where('id', isEqualTo: driver.driverId)
            .get();
        if (userQuerySnapshot.docs.isNotEmpty) {
          await FirebaseFirestore.instance
              .collection('User')
              .doc(userQuerySnapshot.docs.first.id)
              .update({
            'id': driverId,
            'password': driverPassword,
            'name': name,
          });
        }
      } else {
        // If driverId or id already exists, show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Driver ID or ID already exists. Please choose another one.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // If any field is not filled correctly, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteDriverFromFirestore(Driver driver) {
    return FirebaseFirestore.instance
        .collection('drivers')
        .doc(driver.id)
        .delete();
  }

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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('drivers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          drivers.clear();

          snapshot.data!.docs.forEach((document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            drivers.add(Driver.fromMap(document.id, data));
          });

          return ListView.builder(
            itemCount: drivers.length,
            itemBuilder: (context, index) {
              return _buildDriverCard(drivers[index]);
            },
          );
        },
      ),
    );
  }
}

class Driver {
  String id;
  String name;
  String licensePlate;
  String carid;
  String driverId;
  String driverPassword;
  String imageUrl;

  Driver({
    required this.id,
    required this.name,
    required this.licensePlate,
    required this.carid,
    required this.driverId,
    required this.driverPassword,
    required this.imageUrl,
  });

  factory Driver.fromMap(String id, Map<String, dynamic> map) {
    return Driver(
      id: id,
      name: map['name'] ?? '',
      licensePlate: map['licensePlate'] ?? '',
      carid: map['carid'] ?? '',
      driverId: map['driverId'] ?? '',
      driverPassword: map['driverPassword'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }
}
