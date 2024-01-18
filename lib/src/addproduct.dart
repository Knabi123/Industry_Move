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
          controllerproduct: _controllerproduct,
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
            Productname: add_product[index][0],
            Id_product: add_product[index][0],
            Price_product: add_product[index][0],
            Weight_product: add_product[index][0],
            Size_product: add_product[index][0],
            Detail_product: add_product[index][0],
            Unit_product: add_product[index][0],
          );
        },
      ),
    );
  }
}
