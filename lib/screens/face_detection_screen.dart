import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button.dart';

class FaceScreen extends StatefulWidget {
  const FaceScreen({super.key});

  @override
  State<FaceScreen> createState() => _FaceScreenState();
}

class _FaceScreenState extends State<FaceScreen> {
  XFile? image;
  ImagePicker? imagePicker;
  bool isPressed1 = true;

  String headRotationX = '';
  String headRotationY = '';
  bool isFaceDetected = false;
  bool isSmiling = false;
  bool isResult = false;

  Future pickImage(String a) async {
    image = await ImagePicker().pickImage(
        source: a == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      detectFace();
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
              ),
            ],
          ),
        );
      },
    );
  }

  void detectFace() async {
    setState(() {
      isFaceDetected = false;
      isSmiling = false;

      isResult = true;
    });
    final inputImage = InputImage.fromFilePath(image!.path);

    final faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableClassification: true,
        enableLandmarks: true,
        enableContours: true,
        enableTracking: true,
      ),
    );
    final List<Face> faces = await faceDetector.processImage(inputImage);
    if (faces.isNotEmpty) {
      setState(() {
        isFaceDetected = true;
      });
    }
    for (Face face in faces) {
      final double? rotX =
          face.headEulerAngleX; // Head is tilted up and down rotX degrees
      final double? rotY =
          face.headEulerAngleY; // Head is rotated to the right rotY degrees
      setState(() {
        headRotationX = rotX!.toStringAsFixed(2);
        headRotationY = rotY!.toStringAsFixed(2);
      });
      double? smileProb;
      if (face.smilingProbability != null) {
        smileProb = face.smilingProbability;

        if (smileProb! > 0.5) {
          setState(() {
            isSmiling = true;
          });
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {});
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const FaceScreen(),
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
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: const Color(0x33DE3535), width: 1),
                                color: const Color(0x0CDE3535),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Face Detected',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 50),
                                        Text(
                                          isFaceDetected ? 'Yes' : 'No',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Facial Expression',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 35),
                                        Text(
                                          isSmiling ? 'Smiling' : 'Not Smiling',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              color: Color(
                                                (0xFFDE3535),
                                              ),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Head Rotation X',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 37),
                                        Text(
                                          headRotationX,
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          'Head Rotation Y',
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 37),
                                        Text(
                                          headRotationY,
                                          style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                              color: Color(0xFFDE3535),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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
