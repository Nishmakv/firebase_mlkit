import 'package:firebase_project/widgets/grid.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
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
            Container(
              width: 100,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF0073E6),
                borderRadius: BorderRadius.circular(34),
              ),
              child: Center(
                child: Text(
                  'Login',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
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
    );
  }
}
