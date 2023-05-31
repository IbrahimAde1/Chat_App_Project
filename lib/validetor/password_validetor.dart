import 'package:flutter/material.dart';

import '../widgets/castom_snackbar.dart';

String? passwordVaildetor(
    String? data, BuildContext context, String? password) {
  if (data != null) {
    if (data.length < 8 && data.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar(
            backgroundColor: Colors.white,
            color: Colors.black,
            text: 'Password lessthen 8 char.🤨'),
      );
      return 'Password lessthen 8 char';
    } else if (data.isEmpty || password!.isEmpty) {
      return 'Enter password';
    }
  }
  return null;
}
