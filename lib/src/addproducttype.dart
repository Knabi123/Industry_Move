import 'package:company/utils/addtype.dart';
import 'package:flutter/material.dart';

List addtype = [
  ["Fan",false],
  ["Air",false],
];
class Addproducttype extends StatelessWidget {
  const Addproducttype({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Home"),
        elevation: 0,
        

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text("addType"),
        ),
       body: ListView.builder(
       itemCount: addtype.length,
       itemBuilder: (context,index){
        return AddType(taskname: addtype[index][0]);
       },
      ),
    );
   
  }
}