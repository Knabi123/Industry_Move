// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:company/src/addproduct.dart';
import 'package:flutter/material.dart';

class AddType extends StatelessWidget {
  final String taskname;
  final Function(bool?)? onChanged;

  AddType({Key? key, required this.taskname, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25, top: 25),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Addproduct()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            
            color: Color.fromARGB(255, 255, 64, 128),
            borderRadius: BorderRadius.circular(8),
            
          ),
          child: Row(
            children: [
              //task
              Text(taskname),
            ],
          ),
        ),
      ),
    );
  }
}
