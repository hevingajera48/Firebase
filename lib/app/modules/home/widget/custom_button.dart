import 'package:firebase/app/modules/home/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  String? text;
  Color? backColor;
  Color? textColor;
  final double height;
  final double width;
  final VoidCallback press;

  CustomButton({
    super.key,
    this.text,
    this.backColor,
    this.textColor,
    required this.height,
    required this.width,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      elevation: 0,
      color: backColor,
      minWidth: width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onPressed: press,
      child: Text(
        text ?? "",
        style: TextStyle(
          color: textColor,
        ),
      ),
    );
  }
}
