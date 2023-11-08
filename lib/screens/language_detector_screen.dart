import 'package:firebase_project/data/language_detector_function.dart';
import 'package:firebase_project/data/language_list.dart';
import 'package:firebase_project/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageDetector extends StatefulWidget {
  const LanguageDetector({super.key});

  @override
  State<LanguageDetector> createState() => _LanguageDetectorState();
}

class _LanguageDetectorState extends State<LanguageDetector> {
  String result = '';
  String result1 = '';
  bool isClicked = false;
  bool isPressed1 = true;
  List<Data> list = [];
  LanguageClass data1 = LanguageClass();
  final _control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Language Detection',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey,
            height: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller: _control,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFDE3535),
                  )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Type here',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 15),
              Button(
                onButtonTap: () async {
                  list = await data1.detectLanguage(_control.text);
                  setState(() {
                    isClicked = true;
                  });
                },
                text: 'Language detection',
                isPress: isPressed1,
                isIcon: false,
              ),
              const SizedBox(height: 20),
              const SizedBox(width: 20),
              isClicked == true
                  ? SizedBox(
                      width: 300,
                      height: 70,
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 70,
                                // width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0x33DE3535), width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0x0CDE3535),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 13, left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Langauge ID',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Text(
                                            '${list[index].result}',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Confidence',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 48),
                                          Text(
                                            '${list[index].result1}',
                                            style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
