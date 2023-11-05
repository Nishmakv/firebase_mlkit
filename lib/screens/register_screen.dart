import 'package:firebase_project/screens/login_card.dart';
import 'package:firebase_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstnameController = TextEditingController();

  TextEditingController lastnameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  void saveDetails(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(LoginScreen());
                          },
                          icon: const Icon(Icons.arrow_back)),
                      const SizedBox(width: 30),
                      Text(
                        'Create an account',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: Color(0xFF1B1B1F),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LoginCard(
                  controller: firstnameController,
                  label: 'First name',
                  hint: 'Enter first name',
                ),
                LoginCard(
                  controller: lastnameController,
                  label: 'Last name',
                  hint: 'Enter last name',
                ),
                LoginCard(
                  controller: emailController,
                  label: 'Email Address',
                  hint: 'Enter email address',
                ),
                LoginCard(
                  controller: passwordController,
                  label: 'Password',
                  hint: 'Enter password',
                  obscureText: true,
                  password: true,
                ),
                Row(
                  children: [
                    Checkbox(
                        side: const BorderSide(color: Color(0x190A0A0A)),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        }),
                    Text(
                      'I accept all',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          color: Color(0xFF1B1B1F),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Terms of use and privacy policy',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(350, 50),
                    backgroundColor: const Color(0xFF0073E6),
                  ),
                  child: Text(
                    'Register',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
