import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  VoidCallback onButtonTap;

  HomeScreen({
    super.key,
    required this.onButtonTap,
  });

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
                Text(
                  'Image detection identifies objects and patterns',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
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
                  child: Text(
                    'and their attributes.',
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          GestureDetector(
            onTap: widget.onButtonTap,
            child: Container(
              height: 50,
              width: 165,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: const Color.fromARGB(255, 230, 230, 230),
              ),
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
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
          ),
        ],
      ),
    );
  }
}
