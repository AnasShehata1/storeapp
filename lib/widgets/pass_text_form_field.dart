import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField(
      {super.key, required this.hintText, this.onChange});
  final String hintText;
  final Function(String)? onChange;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'This field is required';
        } else if (data.length < 8) {
          return 'The password shouldn\'t be less than 8 characters.';
        } else if (!data.contains(RegExp(r'[A-Z]'))) {
          return 'The password must contain [A-Z].';
        } else if (data.contains(' ')) {
          return 'The password mustn\'t contain space.';
        }
        return null;
      },
      obscureText: !passwordVisible,
      onChanged: widget.onChange,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.lightBlue)),
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black)),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(color: Colors.black)),
        suffixIcon: IconButton(
          icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(
              () {
                passwordVisible = !passwordVisible;
              },
            );
          },
        ),
      ),
    );
  }
}
