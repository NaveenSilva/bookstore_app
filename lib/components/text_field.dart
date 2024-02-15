// ignore_for_file: camel_case_types, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController textcontroller;
  final String hint;
  final bool obscuretext;
  const MyTextField(
      {super.key,
      required this.hint,
      required this.obscuretext,
      required this.textcontroller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: textcontroller,
        obscureText: obscuretext,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: '$hint',
        ),
      ),
    );
  }
}
