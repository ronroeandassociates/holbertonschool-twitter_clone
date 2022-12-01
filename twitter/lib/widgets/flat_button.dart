import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFlatButton extends StatelessWidget {
  // Define property types
  final String label;
  final VoidCallback onPressed;

  // Constructor - all properties must be passed
  const CustomFlatButton(
      {Key? key, required this.label, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // Match width of parent element (full)
        width: double.infinity,
        // Make sure margin on sides so distance from edge
        margin: const EdgeInsets.fromLTRB(20, 40, 20, 50),
        // There are many types of buttons idk
        child: FloatingActionButton.extended(
          // When pressed, call onPressed function
          onPressed: onPressed,
          // Text inside button
          label: Text(
            label,
            // Theme from defined button textTheme in main.dart with modifications added
            style: Theme.of(context).textTheme.button!.copyWith(
                color: Colors.white,
                fontFamily: GoogleFonts.mulish().fontFamily),
          ),
          // Floating action button is raised with shadow by default
          elevation: 0,
          // Specifically told to use background/overlay colors with specific values but
          backgroundColor: Theme.of(context).primaryColor,
        ));
  }
}
