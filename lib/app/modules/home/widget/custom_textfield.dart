import 'package:flutter/material.dart';

import '../../../../constant/app_color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  bool? color = false;
  bool? isEnabled = true;
  final TextInputType? type;
  int? maxLength;

  CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.validator,
    this.color,
    this.type,
    this.isEnabled,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      shadowColor: AppColor.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        enabled: isEnabled,
        maxLength: maxLength,
        style: const TextStyle(fontSize: 14, color: AppColor.black),
        validator: validator,
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColor.grey2,
          border: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
