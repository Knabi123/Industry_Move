// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class Add_product extends StatelessWidget {
  final String Id_product;
  final String Productname;
  final String Price_product;
  final String Unit_product;
  final String Weight_product;
  final String Size_product;
  final String Detail_product;
  Add_product({
    super.key,
    required this.Productname,
    required this.Id_product,
    required this.Detail_product,
    required this.Price_product,
    required this.Size_product,
    required this.Unit_product,
    required this.Weight_product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      child: Container(
        padding: EdgeInsets.all(50),
        child: Row(
          children: [
            Column(
              children: [
                Text(Id_product),
                Text(Productname),
                Text(Price_product),
                Text(Unit_product),
                Text(Weight_product),
                Text(Size_product),
                Text(Detail_product),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
