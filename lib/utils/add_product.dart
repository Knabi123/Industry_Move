// ignore_for_file: camel_case_types, non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';

class Add_product extends StatelessWidget {
  final String Id_product;
  final String Productname;
  final String Price_product;
  final String Unit_product;
  final String Weight_product;
  final String Size_product;
  final String Detail_product;
   final String imageUrl;


  
  Add_product({
    super.key,
    required this.Productname,
    required this.Id_product,
    required this.Detail_product,
    required this.Price_product,
    required this.Size_product,
    required this.Unit_product,
    required this.Weight_product,
    required this.imageUrl,
   
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10, top: 10),
      
      child: Container(
        padding: EdgeInsets.all(20),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Id_product),
                SizedBox(width: 8),
                Text(Productname),
              ],
            ),
            Text(Detail_product),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Weight_product),
                SizedBox(width: 8),
                Text(Size_product),
              ],
            ),
            Row(
            
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Price_product),
                SizedBox(width: 5),
                Text("Bath"),
                SizedBox(width: 10),
                Text(Unit_product),
                 if (imageUrl.isNotEmpty) // Display image if available
              Image.file(File(imageUrl)),
              ],
              
            ),
         Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Handle edit action
                    // You can open a new dialog or navigate to an edit screen
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Handle delete action
                    // You can show a confirmation dialog and then delete the item
                  },
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
