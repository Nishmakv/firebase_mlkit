import 'package:firebase_project/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class LoginCard extends StatefulWidget {
  final TextEditingController controller;
  String label;
  String hint;
  bool obscureText;
  bool forgotPassword;
  bool password;

  LoginCard({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.obscureText = false,
    this.forgotPassword = false,
    this.password = false,
  });

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.label,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1B1B1F),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  widget.forgotPassword
                      ? TextButton(
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xFF0073E6),
                                fontWeight: FontWeight.w500,
                                fontSize: 12.5,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => const OtpScreen(),
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                ],
              ),
              widget.forgotPassword
                  ? const SizedBox()
                  : const SizedBox(height: 12),
              SizedBox(
                height: 53,
                width: 350,
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 1,
                        color: Color(0x190A0A0A),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    hintText: widget.hint,
                    contentPadding: const EdgeInsets.all(22),
                    hintStyle: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    suffixIcon: widget.password
                        ? IconButton(
                            color: const Color.fromARGB(114, 10, 10, 10),
                            icon: Icon(_obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined),
                            onPressed: () {
                              setState(() {
                                widget.obscureText = !widget.obscureText;
                                _obscureText = !_obscureText;
                              });
                            },
                          )
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
