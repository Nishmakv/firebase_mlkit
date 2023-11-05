import 'dart:async';

import 'package:firebase_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isClick = false;
  bool isColour = false;
  Timer? _timer;
  int _secondsRemaining = 30;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    _secondsRemaining = 30;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  void requestNewOTP() {
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => LoginScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80, top: 10),
                      child: Text(
                        'OTP Verification',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: Color(0xFF1B1B1F),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            height: 0.06,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  child: Pinput(
                    length: 5,
                    onChanged: (value) {
                      for (int i = 5; i <= value.length; i++) {
                        if (value.length >= 0) {
                          setState(() {
                            isColour = true;
                          });
                        } else {
                          setState(() {
                            isColour = false;
                          });
                        }
                      }
                      _secondsRemaining > 0
                          ? Text('reequest new otp in $_timer')
                          : SizedBox();
                    },
                    onCompleted: (value) {},
                    onSubmitted: (value) {},
                    defaultPinTheme: PinTheme(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isColour == true
                              ? Colors.black
                              : const Color.fromARGB(255, 224, 204, 204),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                isClick == true
                    ? ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isClick = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(307, 45),
                          backgroundColor: const Color(0xFF0073E6),
                        ),
                        child: Text(
                          'Continue',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          // startTimer();
                          setState(() {
                            isClick = true;
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(307, 45),
                          backgroundColor: const Color(0xFFD3D3D3),
                        ),
                        child: Text(
                          'Confirm OTP',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                isClick == true
                    ? Row(
                        children: [
                          // Text('00:$start'),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Dont receive the OTP?',
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                color: Color(0xFF1B1B1F),
                                fontSize: 14,
                                height: 0.08,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Resend',
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
                                  color: Color(0xFF0073E6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 0.08,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
