import 'package:firebase_project/main.dart';
import 'package:firebase_project/screens/login_screen.dart';
import 'package:firebase_project/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: SafeArea(
          child: Drawer(
            backgroundColor: Colors.white,
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  accountName: Text(
                    'Afthabu Rahman',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        color: Color(0xFF32322C),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  accountEmail: Text(
                    'afthabrahman@gmail.com',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF55636C),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/images/Ellipse 841.png'),
                  ),
                  otherAccountsPictures: [
                    const SizedBox(height: 500),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: const Color(0xFFEBEBEB),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        leading:
                            SvgPicture.asset('assets/images/Group 29796.svg'),
                        title: Text(
                          'Profile Details',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Color(0xFF313131),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('assets/images/credit_icon.svg'),
                        title: Text(
                          'Change Password',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Color(0xFF32322C),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading:
                            SvgPicture.asset('assets/images/translate.svg'),
                        title: Text(
                          'Language Settings',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Color(0xFF32322C),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset('assets/images/support.svg'),
                        title: Text(
                          'Help and Support',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Color(0xFF32322C),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset('assets/images/settings.svg'),
                        title: Text(
                          'Logout',
                          style: GoogleFonts.roboto(
                            textStyle: const TextStyle(
                              color: Color(0xFF32322C),
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              title: Text(
                                'Logout from the app ?',
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              content: Builder(builder: (context) {
                                // var height = MediaQuery.of(context).size.height;
                                var height = 50;

                                // var width = MediaQuery.of(context).size.width;
                                var width = 500;
                                return SizedBox(
                                  height: height - 10,
                                  width: width - 50,
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(
                color: Colors.black,
                height: 0.1,
              ),
            ),
            toolbarHeight: 80, //to determine the height of appbar.
            backgroundColor: const Color(0xFFF8F7F5),
            automaticallyImplyLeading: false,
            foregroundColor: Colors.black,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: SvgPicture.asset(
                              'assets/images/Icons-Menu-Burger.svg'),
                        );
                      },
                    ),
                    Image.asset(
                      'assets/images/Group 30810 (1).png',
                      width: 65,
                    ),
                  ],
                ),
                Center(
                  child: Image.asset(
                    'assets/images/Ellipse 841.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            )),
        body: SingleChildScrollView(
          child: SizedBox(
            //height: MediaQuery.of(context).size.height,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Every app in one place',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 3.0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Expanded(
                    child: GridScreen(),
                  ),
                  IconButton(
                    onPressed: () {
                      signOut(context);
                    },
                    icon: Icon(Icons.exit_to_app),
                  ),
                  Text(
                    'Copyright @interns2023 all rights reserved',
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Image.asset(
                    'assets/images/Group 30809.png',
                    width: 140,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signOut(BuildContext ctx) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool("isLogin", false);

    // await sharedPrefs.clear();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => LoginScreen(),
      ),
    );
  }
}
