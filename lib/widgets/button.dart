import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  VoidCallback onButtonTap;
  String text;
  bool isPress;
  bool isIcon;

  Button({
    super.key,
    required this.onButtonTap,
    required this.text,
    required this.isPress,
    required this.isIcon,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isIcon == true
                ? const Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                  )
                : const SizedBox(),
            const SizedBox(width: 15),
            Text(
              text,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: isPress ? Colors.white : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
