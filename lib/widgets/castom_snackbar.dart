import 'package:flutter/material.dart';

SnackBar snackBar(
    {required Color backgroundColor,
    required Color? color,
    required String? text}) {
  return SnackBar(
    backgroundColor: backgroundColor,
    content: Text(style: TextStyle(color: color), text!),
  );
}
