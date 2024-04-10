

import 'package:flutter/material.dart';

class TextFormF extends StatelessWidget {
  final String placeholder;
  final String? Function(String?)? validator; 
  final int maxLines;
  final TextEditingController controller;
  final bool obsecureText;
  const TextFormF({required this.placeholder, this.validator,  this.obsecureText = false, required this.maxLines, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(
        border: const OutlineInputBorder(),
        hintText: placeholder,
      ),
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      obscureText: obsecureText,
    );
  }
}