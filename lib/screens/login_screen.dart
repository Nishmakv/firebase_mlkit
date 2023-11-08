import 'package:firebase_project/main.dart';
import 'package:firebase_project/screens/home_page.dart';
import 'package:firebase_project/screens/login_card.dart';
import 'package:firebase_project/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  bool isLogin = false;
  late SharedPreferences sharedPrefs;
@override
  void initState() {
    checkUserLoggedIn();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  'Welcome back!',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: Color(0xFF1B1B1F),
                      height: 2,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                  forgotPassword: true,
                  password: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    checkLogin(context);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New to sidra store ?',
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xFF1B1B1F),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => const RegisterScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF0073E6),
                            fontWeight: FontWeight.w500,
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

  void checkLogin(BuildContext ctx) async {
    final _email = emailController.text;
    final _password = passwordController.text;
    if (_email == _password) {
      
      final sharedPrefs = await SharedPreferences.getInstance();
      await sharedPrefs.setBool("isLogin", true);
     
      print('email and password match');

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
    } else {
      print('emal and password doesnot match');
    }
  }
  
  void checkUserLoggedIn() async {
    final sharedPrefs = await SharedPreferences.getInstance();

    final userLoggedIn = sharedPrefs.getBool("isLogin") ?? false;
    if (userLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => HomePage(),
        ),
      );
    }
  }
}
