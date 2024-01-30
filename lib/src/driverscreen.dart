import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class DriverDetailPage extends StatefulWidget {
  @override
  _DriverDetailPageState createState() => _DriverDetailPageState();
}

class _DriverDetailPageState extends State<DriverDetailPage> {
  List<Driver> drivers = [];
  File? _imageFile; 

  Future<void> _getImage() async {
final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
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
      body: ListView.builder(
        itemCount: drivers.length,
        itemBuilder: (context, index) {
          return _buildDriverCard(drivers[index]);
        },
      ),
    );
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
        ? Image.file(
            File(imageUrl),
            height: 100,
            width: 100,
            fit: BoxFit.cover,
          )
        : Container();
  }

  bool shouldShowDriverDetails(Driver driver) {
    return false; // นำเสนอโค้ดที่เหมาะสมสำหรับตรวจสอบเงื่อนไขแสดงรายละเอียดของคนขับ
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
              setState(() {
             
                _imageFile = null;
              });
              Navigator.pop(context);
            }),
            _buildDialogButton('Add', () {
              setState(() {
                drivers.add(Driver(
                  name: name,
                  carid: carid,
                  licensePlate: licensePlate,
                  driverId: driverId,
                  driverPassword: driverPassword,
                  imageUrl: _imageFile?.path ?? '',
                ));
              
                _imageFile = null;
              });
              Navigator.pop(context);
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
                  _buildImageField(initialValue: driver.imageUrl), // เพิ่มวิดเจ็ตรูปภาพ
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
                  driver.driverId = driverId;
                  driver.driverPassword = driverPassword;
                  driver.imageUrl = _imageFile?.path ?? driver.imageUrl; // ใช้ path ของรูปที่เลือก
                });
                Navigator.pop(context);
              }),
            ],
          ),
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
    TextEditingController controller = TextEditingController(text: initialValue);

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
          _imageFile != null
              ? Image.file(
                  _imageFile!,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                )
              : initialValue != null
                  ? _buildDriverImage(initialValue)
                  : Container(),
        ],
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
  String imageUrl;

  Driver({
    required this.name,
    required this.licensePlate,
    required this.carid,
    required this.driverId,
    required this.driverPassword,
    required this.imageUrl,
  });
}
