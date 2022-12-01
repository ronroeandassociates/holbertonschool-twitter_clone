import 'package:flutter/material.dart';

class CustomEntryField extends StatelessWidget {
  // Define property types
  final String hint;
  final TextEditingController controller;
  final bool isPassword;

  // Constructor - all properties must be passed
  const CustomEntryField(
      {Key? key,
      required this.hint,
      required this.controller,
      required this.isPassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // Margin around each text field - requires wrapped in Container
      margin: const EdgeInsets.all(20),
      // Each text field is centered inside container
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hint,
            // Background and color
            filled: true,
            fillColor: Colors.grey[200],
            // Hint/placeholder text
            hintStyle: TextStyle(
                color: Theme.of(context).primaryColorLight, fontSize: 20),
            // Padding around text itself within field
            contentPadding: const EdgeInsets.fromLTRB(30, 15, 0, 15),
            // Border around field
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: (Colors.grey[200])!),
            ),
            // Border around field when focused
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
          ),
        ),
      ),
    );
  }
}
