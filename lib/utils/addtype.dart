import 'package:flutter/material.dart';

class AddType extends StatelessWidget {
  final String taskname;
  Function(bool?)? onChanged;
  AddType({super.key, required this.taskname});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0,right: 25,top: 25),
      child: Container(
        padding: EdgeInsets.all(24),
        child: Row(
          children: [

            //task
            Text(taskname),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.pink,
          borderRadius: BorderRadius.circular(12)
        ),
      )
      
      );
  }
}