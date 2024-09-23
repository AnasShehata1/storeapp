import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.onChange,
      this.inputType,
      this.enabled});
  final String hintText;
  final Function(String)? onChange;
  final TextInputType? inputType;
  final bool? enabled;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onChanged: onChange,
      keyboardType: inputType,
      decoration: InputDecoration(
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
    );
  }
}
