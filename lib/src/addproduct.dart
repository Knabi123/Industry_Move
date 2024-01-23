// ignore_for_file: non_constant_identifier_names, library_private_types_in_public_api, prefer_const_constructors

import 'package:company/utils/add_product.dart';
import 'package:company/utils/dialog_product.dart';
import 'package:flutter/material.dart';

List add_product = [];

final _controllerproduct = TextEditingController();

class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  _AddproductState createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  void saveNewProduct() {
    setState(() {
      add_product.add([_controllerproduct.text, false]);
    });
    Navigator.of(context).pop();
  }

  void createNewProduct(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialogboxproduct(
          onSave: saveNewProduct,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewProduct(context),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: add_product.length,
        itemBuilder: (context, index) {
          return Add_product( 
            Id_product: 'ID : ${index + 1}',
            Productname: add_product[index][0],
            Detail_product: 'Detail : ${add_product[index][0]}',
            Price_product: 'Price : ${add_product[index][0]}',
            Unit_product: 'Unit : ${add_product[index][0]}',
            Weight_product: 'Weight : ${add_product[index][0]}',
            Size_product: 'Size : ${add_product[index][0]}',
            imageUrl: add_product[index][0],
            
          );
        },
      ),
    );
  }
}
