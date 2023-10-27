import 'package:firebase_project/data/language_detector_function.dart';
import 'package:firebase_project/data/language_list.dart';
import 'package:firebase_project/widgets/button.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text(
          'Language Detection',
          style:  TextStyle(color: Colors.black),
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Type here',
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Button(
                onButtonTap: () async {
                  list = await data1.detectLanguage(_control.text);
                  setState(() {
                    isClicked = true;
                  });
                },
                text: 'Language detection',
                isPress: isPressed1,
              ),
              const SizedBox(height: 25),
              const SizedBox(width: 20),
              isClicked == true
                  ? SizedBox(
                      width: 300,
                      height: 80,
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                        248, 161, 144, 144),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(25, 0, 0, 0),
                                      blurRadius: 1,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text('Langauge ID:'),
                                        ),
                                        const SizedBox(width: 40),
                                        Text('${list[index].result}'),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Text('Confidence:'),
                                        ),
                                        const SizedBox(width: 48),
                                        Text('${list[index].result1}'),
                                      ],
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
