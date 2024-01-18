// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'User_Page/oder_user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Order_user(),
    );
  }
}
