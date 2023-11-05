import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LabelDisplay extends StatelessWidget {
  String label;
  bool isSelect;

  LabelDisplay({super.key, required this.label, required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8.0,
      ),
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x33DE3535), width: 1),
          color: const Color(0x0CDE3535),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              label,
              style: GoogleFonts.inter(
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              softWrap: true,
            ),
          ],
        ),
      ),
    );
  }
}
