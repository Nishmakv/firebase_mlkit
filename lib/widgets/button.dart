import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  VoidCallback onButtonTap;
  String text;
  bool isPress;

  Button({
    super.key,
    required this.onButtonTap,
    required this.text,
    required this.isPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        height: 55,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: isPress ? const Color(0xFFDE3535) : const Color(0xFFF6F6F6),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: isPress ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
