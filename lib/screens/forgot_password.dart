import 'package:firebase_project/screens/home_page.dart';
import 'package:firebase_project/screens/login_card.dart';
import 'package:firebase_project/screens/login_screen.dart';
import 'package:firebase_project/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class PasswordScreen extends StatelessWidget {
  PasswordScreen({super.key});
  TextEditingController emailController = TextEditingController();

  void saveDetails(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Forgot Password',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xFF1B1B1F),
                          height: 0.06,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              LoginCard(
                controller: emailController,
                label: 'Email Address',
                hint: 'Enter email address',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const HomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(720, 50),
                  backgroundColor: const Color(0xFF0073E6),
                ),
                child: Text(
                  'Login',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.only(left: 122, right: 110),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Back to',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                            color: Color(0xFF1B1B1F),
                          ),
                        ),
                      ),
                      const WidgetSpan(
                        child: SizedBox(width: 7),
                      ),
                      TextSpan(
                        text: 'Login',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0073E6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             
            ],
          ),
        ),
      ),
    ));
  }
}
