import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText, this.onChange, this.inputType, this.onSubmitted});
  final String hintText;
  final Function(String)? onChange;
  final Function(String)? onSubmitted;
  final TextInputType? inputType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      keyboardType: inputType,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
    );
  }
}
