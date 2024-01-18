// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class ButtonProduct extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  ButtonProduct({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      child: Text(text),
    );
  }
}
