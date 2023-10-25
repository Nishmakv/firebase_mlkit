import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/screens/language_detector_screen.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button.dart';

class ImageAddScreen extends StatefulWidget {
  const ImageAddScreen({super.key});

  @override
  State<ImageAddScreen> createState() => _ImageAddScreenState();
}

class _ImageAddScreenState extends State<ImageAddScreen> {
  XFile? image;
  ImagePicker? imagePicker;
  String text = "";
  bool isPressed1 = false;
  bool isPressed2 = false;
  String headRotationX = '';
  String headRotationY = '';
  String tab = '';
  bool isFaceDetected = false;
  bool isSmiling = false;

  Future pickImage(String a) async {
    image = await ImagePicker().pickImage(
        source: a == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    setState(() {});
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
                  pickImage('Camera');
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Gallery'),
                onTap: () {
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
        isPressed2 = true;
        isPressed1 = false;

        text = "";
        tab = "text";
      },
    );
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

    final inputImage = InputImage.fromFilePath(image!.path);

    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      setState(() {
        text += "${block.text}";
      });
    }
    textRecognizer.close();
  }

  void detectFace() async {
    setState(() {
      isFaceDetected = false;
      isSmiling = false;
      isPressed2 = false;
      isPressed1 = true;
      text = "";
      tab = 'face';
    });
    final inputImage = InputImage.fromFilePath(image!.path);

    final faceDetector = FaceDetector(
        options: FaceDetectorOptions(
      enableClassification: true,
      enableLandmarks: true,
      enableContours: true,
      enableTracking: true,
    ));
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
        headRotationX = rotX.toString();
        headRotationY = rotY.toString();
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
    FirebaseMessaging.onMessage.listen((event) {
      print("eventtttt.... $event");
    });
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          tab = '';
        });
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const ImageAddScreen(),
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const LanguageDetector(),
                              ),
                            );
                          },
                        )
                      : Column(
                          children: [
                            Container(
                              width: 300,
                              height: 250,
                              color: const Color.fromARGB(255, 246, 246, 246),
                              child: SizedBox(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 35, right: 35),
                                      child: SizedBox(
                                        height: 250,
                                        width: 400,
                                        child: Image.file(
                                          File(image!.path),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 25,
                                      left: 92,
                                      child: Container(
                                        width: 117,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            modelBottomSheet(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          icon: const Icon(
                                            Icons.cloud_upload_outlined,
                                            color: Colors.black,
                                          ),
                                          label: Text(
                                            'Change',
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                color: Color(0xFF1B1B1F),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Expanded(
                                  child: Button(
                                    onButtonTap: detectFace,
                                    text: "Detect face",
                                    isPress: isPressed1,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Expanded(
                                  child: Button(
                                    onButtonTap: detectText,
                                    text: "Detect Text",
                                    isPress: isPressed2,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(height: 10),
                  tab == 'face'
                      ? Column(
                          children: [
                            Container(
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
                                    Row(
                                      children: [
                                        const Text('Detected'),
                                        Text(isFaceDetected ? 'Yes' : 'No'),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Facial expression'),
                                        Text(
                                          isSmiling ? 'Smiling' : 'Not Smiling',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Container(
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
                                    Row(
                                      children: [
                                        const Text("Head Rotation in X axis"),
                                        Text(headRotationX),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Head Rotation in Y axis'),
                                        Text(
                                          headRotationY,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  tab == "text"
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
                                SizedBox(height: 10),
                                Text(text == "" ? "No text detected" : text),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
