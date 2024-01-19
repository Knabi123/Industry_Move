import 'package:flutter/material.dart';
import 'dart:io';
import 'package:company/utils/add_driver.dart';

class DetailDriverPage extends StatefulWidget {
  @override
  _DetailDriverPageState createState() => _DetailDriverPageState();
}

class _DetailDriverPageState extends State<DetailDriverPage> {
  File? _image;
  String? _driverId;
  String? _driverPassword;
  String? _driverName;
  String? _carId;
  String? _licenseId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Driver Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddDriverDialog(context);
            },
          ),
        ],
      ),
      body: _buildDriverDetails(),
    );
  }

  Widget _buildDriverDetails() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 3.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_image != null) _buildImageItem(),
                if (_driverName != null)
                  _buildDetailItem('Driver Name: $_driverName'),
                if (_driverId != null)
                  _buildDetailItem('Driver ID: $_driverId'),
                if (_driverPassword != null)
                  _buildDetailItem('Driver Password: $_driverPassword'),
                if (_carId != null) _buildDetailItem('Car ID: $_carId'),
                if (_licenseId != null)
                  _buildDetailItem('License ID: $_licenseId'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageItem() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100.0,
                width: 300.0,
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
                          Image.file(
                            _image!,
                            height: 80.0,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddDriverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddDriverDialog(
          onDriverAdded: (DriverInfo) {},
        );
      },
    );
  }
}
