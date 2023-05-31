import 'package:flutter/material.dart';

import '../widgets/castom_snackbar.dart';

String? emialValidetor(
    String? data, BuildContext context, String? emailAddress) {
  if (data!.isNotEmpty) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(data);

    if (emailValid == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBar(
            backgroundColor: Colors.white,
            color: Colors.black,
            text: 'Valid email.🤨'),
      );
      return 'valid email';
    }
  } else if (data.isEmpty || emailAddress!.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      snackBar(
          backgroundColor: Colors.white,
          color: Colors.black,
          text: 'Enter email.🤨'),
    );
    return 'Enter email';
  }
  return null;
}
