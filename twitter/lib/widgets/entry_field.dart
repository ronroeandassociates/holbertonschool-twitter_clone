import 'package:flutter/material.dart';
// Stateless widget CustomEntryField

class CustomEntryField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassword; // default is false

  const CustomEntryField({
    Key? key,
    required this.hint,
    required this.controller,
    this.isPassword = false, // cannot be required since default is false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // container styling
      margin: const EdgeInsets.all(15),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType:
            isPassword ? TextInputType.visiblePassword : TextInputType.text,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade200,
            fontSize: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey.shade200,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}
