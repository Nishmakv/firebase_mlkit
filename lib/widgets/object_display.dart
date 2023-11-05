import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ObjectDisplay extends StatelessWidget {
  String label;
  bool isSelect;
  double accuracy;

  ObjectDisplay(
      {super.key,
      required this.label,
      required this.isSelect,
      required this.accuracy});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0x33DE3535), width: 1),
          borderRadius: BorderRadius.circular(5),
          color: const Color(0x0CDE3535),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 13, left: 10),
              child: Row(
                children: [
                  Text(
                    'Category ',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(width: 70),
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Text(
                    'Accuracy Level',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(width: 38),
                  Text(
                    accuracy.toStringAsFixed(2),
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
