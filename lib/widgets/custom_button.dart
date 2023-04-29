import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.width,
      required this.height,
      required this.textButtom,
      required this.backColor,
      required this.textcolor,
      required this.fontSize,
      required this.fontWeight,
      required this.borderRadius});
  final String? textButtom;
  final double? fontSize;
  final Color? textcolor;
  final FontWeight? fontWeight;
  final Color? backColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GlassContainer.clearGlass(
      width: width!, borderColor: Colors.transparent,
      height: height!, blur: 20,
      borderRadius: BorderRadius.circular(borderRadius!),
      alignment: Alignment.center, shadowColor: Colors.blue,
      // gradient: LinearGradient(colors: [Colors.orange, Colors.red]),
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(borderRadius!), color: backColor),
      // alignment: Alignment.center,
      child: Text(
        textAlign: TextAlign.center,
        textButtom!,
        style: TextStyle(
            color: textcolor, fontSize: fontSize, fontWeight: fontWeight),
      ),
    );
  }
}
