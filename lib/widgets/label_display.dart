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
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFF9F9F9),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 1,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          height: 50,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                label,
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600)),
                softWrap: true,
              ),
            ],
          )),
    );
  }
}
