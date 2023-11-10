// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_project/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/home_page.dart';
import 'package:firebase_project/screens/login_card.dart';
import 'package:firebase_project/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final formkey = GlobalKey<FormState>();

  bool isChecked = false;

  void saveDetails(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
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
                    validatorvar: true,
                  ),
                  LoginCard(
                    controller: lastnameController,
                    label: 'Last name',
                    hint: 'Enter last name',
                    validatorvar: true,
                  ),
                  LoginCard(
                    controller: emailController,
                    label: 'Email Address',
                    hint: 'Enter email address',
                    validatorvar: false,
                  ),
                  LoginCard(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter password',
                    obscureText: true,
                    password: true,
                    validatorvar: true,
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
                    onPressed: () async {
                      var validIs = formkey.currentState!.validate();
                      if (validIs == true) {
                        FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) async => {
                                  checkLogin(),
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (ctx) => const HomePage(),
                                    ),
                                  )
                                })
                            .onError(
                          (error, stackTrace) {
                            try {
                              final snackBar = SnackBar(
                                content: Text(
                                  'The Email address is already registered',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                backgroundColor: Colors.red,
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } catch (e) {
                              print('Error: $e');
                            }
                            return {};
                          },
                        );
                      }
                    },
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
                          color: Color.fromARGB(255, 228, 233, 238),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool("isLogin", true);
  }
}
