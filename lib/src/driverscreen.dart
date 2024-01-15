import 'package:flutter/material.dart';

class DriverScreen extends StatelessWidget {
  const DriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("driver",
        style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}