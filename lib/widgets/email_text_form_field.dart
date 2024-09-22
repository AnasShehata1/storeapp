import 'package:flutter/material.dart';

class EmailTextFormField extends StatelessWidget {
  const EmailTextFormField({super.key, required this.hintText, this.onChange});
  final String hintText;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (data) {
        if (data!.isEmpty) {
          return 'This field is required';
        } else if (!data.contains(RegExp(r'@[a-z]')) ||
            !data.contains('.com')) {
          return 'The domain of email is required ex: user@email.com .';
        } else if (data.contains(RegExp(r'[!-,]')) ||
            data.contains(RegExp(r'[:-?]')) ||
            data.contains('[') ||
            data.contains(']') ||
            data.contains('/') ||
            data.contains('~') ||
            data.contains('`') ||
            data.contains('^') ||
            data.contains(' ')) {
          return 'The email mustn\'t contain space and some special characters.';
        }
        return null;
      },
      onChanged: onChange,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        hintStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
        hintText: hintText,
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
      ),
    );
  }
}
