import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CastomTextFiled extends StatelessWidget {
  CastomTextFiled({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.icon,
    required this.onChanged,
    required this.vaildite,
    required this.controller,
    required this.keyboardType,
    required this.obscureText,
    required this.autofocus,
  });
  TextEditingController controller = TextEditingController();
  String labelText;
  String hintText;
  bool autofocus;
  bool obscureText;
  TextInputType keyboardType;

  Icon icon;
  String? Function(String?) vaildite;
  Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      validator: vaildite,
      autofocus: autofocus,
      obscureText: obscureText,
      onChanged: onChanged!,
      decoration: InputDecoration(
          suffixIcon: icon,
          fillColor: Colors.white,
          hintText: hintText,
          labelText: labelText,
          hintStyle: const TextStyle(color: Colors.white),
          labelStyle: const TextStyle(color: Colors.blue),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white))),
      style: const TextStyle(color: Colors.white),
    );
  }
}
