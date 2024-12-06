import 'package:flutter/material.dart';

class CustomeField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObsecure;
  const CustomeField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObsecure = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObsecure,
      controller: controller,
      decoration: InputDecoration(hintText: hintText),
      validator: (val) {
        if (val!.trim().isEmpty) {
          return "$hintText is missing !";
        }
        return null;
      },
    );
  }
}
