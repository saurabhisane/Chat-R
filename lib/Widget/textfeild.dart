import 'package:flutter/material.dart';

Widget buildTextField(String label, bool isPassword,
    TextEditingController controller, String? Function(String?)? validator) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    validator: validator,
  );
}
