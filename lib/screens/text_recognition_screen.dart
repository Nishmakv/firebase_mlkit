import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button.dart';

class TextScreen extends StatefulWidget {
  const TextScreen({super.key});

  @override
  State<TextScreen> createState() => _TextScreenState();
}

class _TextScreenState extends State<TextScreen> {
  XFile? image;
  ImagePicker? imagePicker;
  String text1 = "";
  bool isPressed1 = true;
  bool isResult = false;

  Future pickImage(String a) async {
    image = await ImagePicker().pickImage(
        source: a == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      detectText();
    });
  }

  void modelBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage('Camera');
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  pickImage('Gallery');
                },
              )
            ],
          ),
        );
      },
    );
  }

  void detectText() async {
    setState(
      () {
        text1 = "";
        isResult = true;
      },
    );
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final inputImage = InputImage.fromFilePath(image!.path);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      setState(() {
        text1 += "${block.text}";
      });
    }
    textRecognizer.close();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      //print("eventtttt.... $event");
    });
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const TextScreen(),
              ),
            );
          },
          child: Image.asset(
            'assets/images/Group 30800 (4).png',
            width: 150,
          ),
        ),
        backgroundColor: const Color(0xFFF8F7F5),
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                image == null
                    ? HomeScreen(
                        onButtonTap: () {
                          modelBottomSheet(context);
                        },
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: SizedBox(
                              height: 250,
                              width: 350,
                              child: Image.file(
                                File(image!.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: Button(
                              onButtonTap: () {
                                modelBottomSheet(context);
                              },
                              text: "Change",
                              isPress: isPressed1,
                              isIcon: true,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                isResult == true
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0x33DE3535), width: 1),
                          color: const Color(0x0CDE3535),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Result',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(text1 == "" ? "No text detected" : text1),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
