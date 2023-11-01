import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:firebase_project/widgets/label_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button.dart';

class ObjectDetectionScreen extends StatefulWidget {
  const ObjectDetectionScreen({super.key});

  @override
  State<ObjectDetectionScreen> createState() => ObjectDetectionScreenState();
}

class ObjectDetectionScreenState extends State<ObjectDetectionScreen> {
  XFile? image;
  ImagePicker? imagePicker;
  bool isPressed1 = false;
  bool isPressed2 = false;
  List list = [];
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

  String? text;
  String result = "";

  Future getobjectdetect() async {
    setState(() {
      list = [];
    });

    final inputImage = InputImage.fromFilePath(image!.path);
    ObjectDetector detector = ObjectDetector(
        options: ObjectDetectorOptions(
            mode: DetectionMode.single,
            classifyObjects: true,
            multipleObjects: true));
    final List<DetectedObject> objdetect =
        await detector.processImage(inputImage);
    for (DetectedObject object in objdetect) {
      // String confi;
      final rect = object.boundingBox;
      final trackingId = object.trackingId;
      for (Label label in object.labels) {
        String text = label.text;
        double confidence = label.confidence;
        // String confi=confidence.toString();
        int index = label.index;
        setState(() {
          result =
              "Category: $text\n$rect\nTrackinId: $trackingId\nConfidence: ${confidence.toStringAsFixed(2)}\nIndex: $index";
          list.add(result);
        });

        print(result);
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
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const ObjectDetectionScreen(),
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
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          modelBottomSheet(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color.fromRGBO(
                                              255, 255, 255, 1),
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
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: Button(
                              onButtonTap: getobjectdetect,
                              text: "Detect Object",
                              isPress: isPressed1,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                // isResult == true
                Column(
                  children: [
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return LabelDisplay(
                              label: list[index], isSelect: true);
                        })
                  ],
                )
                //  : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
