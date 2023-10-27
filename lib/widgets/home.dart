import 'package:firebase_project/screens/digital_ink.dart';
import 'package:firebase_project/screens/text_recognition_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  VoidCallback onButtonTap;
  VoidCallback onTap;
  HomeScreen({super.key, required this.onButtonTap, required this.onTap});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Image(
              image: AssetImage('assets/images/Group 30802.png'),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Image detection identifies objects and patterns',
                    style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ))),
                // const SizedBox(height: 5),
                Text(
                  'in pictures,while facial-analysis faces',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 85),
                  child: Text('and their attributes.',
                      style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ))),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: widget.onButtonTap,
                  child: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color(0xFFF6F6F6),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          //onPressed: widget.onButtonTap,
                          onPressed: () {
                            ;
                            widget.onTap;
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (ctx) => TextScreen(),
                            //   ),
                            // );
                          },
                          icon: const Icon(Icons.cloud_upload_outlined),
                        ),
                        Text(
                          'Upload Image',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 15),
                // GestureDetector(
                //   onTap: widget.onTap,
                //   child: Container(
                //     height: 50,
                //     width: 200,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(7),
                //       color: const Color(0xFFF6F6F6),
                //     ),
                //     child: Row(
                //       children: [
                //         IconButton(
                //           onPressed: widget.onTap,
                //           icon: const Icon(Icons.note_alt),
                //         ),
                //         Text(
                //           'Language Detector',
                //           style: GoogleFonts.poppins(
                //             textStyle: const TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 15),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.of(context).push(
                //       MaterialPageRoute(
                //         builder: (ctx) => const SignatureCanvas(),
                //       ),
                //     );
                //   },
                //   child: Container(
                //     height: 50,
                //     width: 200,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(7),
                //       color: const Color(0xFFF6F6F6),
                //     ),
                //     child: Row(
                //       children: [
                //         IconButton(
                //           onPressed: () {},
                //           icon: const Icon(Icons.text_decrease_outlined),
                //         ),
                //         Text(
                //           'Ink Detector',
                //           style: GoogleFonts.poppins(
                //             textStyle: const TextStyle(
                //               fontSize: 14,
                //               fontWeight: FontWeight.w500,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
