import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeButtonScreen extends StatefulWidget {
  Color? color;
  Icon? icon;
  String name;
  VoidCallback onTapButton;

  HomeButtonScreen(
      {super.key,
      required this.color,
      required this.icon,
      required this.name,
      required this.onTapButton});

  @override
  State<HomeButtonScreen> createState() => _HomeButtonScreenState();
}

class _HomeButtonScreenState extends State<HomeButtonScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapButton,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: widget.icon,
              ),
              Positioned(
                right: 45,
                bottom: 40,
                child: CircleAvatar(
                  backgroundColor:
                      Colors.white.withOpacity(0.20999999344348907),
                  //radius: 12,
                  radius: 25,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            widget.name,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(
              fontSize: 12,
            )),
          ),
        ],
      ),
    );
  }
}
