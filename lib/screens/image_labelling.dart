import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:firebase_project/widgets/label_display.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button.dart';

class ImageLabellingScreen extends StatefulWidget {
  const ImageLabellingScreen({super.key});

  @override
  State<ImageLabellingScreen> createState() => ImageLabellingScreenState();
}

class ImageLabellingScreenState extends State<ImageLabellingScreen> {
  XFile? image;
  ImagePicker? imagePicker;
  bool isPressed1 = true;

  List list = [];
  Future pickImage(String a) async {
    image = await ImagePicker().pickImage(
        source: a == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      getImagelabel();
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

  String? text;
  String result = "";

  Future<List> getImagelabel() async {
    setState(() {
      list = [];
    });

    final inputImage = InputImage.fromFilePath(image!.path);
    ImageLabeler imageLabeler =
        ImageLabeler(options: ImageLabelerOptions(confidenceThreshold: 0.5));
    final List<ImageLabel> labels = await imageLabeler.processImage(inputImage);
    for (ImageLabel label in labels) {
      String text = label.label;
      double confidence = label.confidence;
      int index = label.index;
      setState(() {
        // result = "$text :: $confidence :: $index\n";
        result = "$text";
        list.add(result);
      });
    }
    imageLabeler.close();
    return list.toList();
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const ImageLabellingScreen(),
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

                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    children: [
                      Container(
                        height: 418,
                        decoration: const BoxDecoration(
                          color: Color(0x0CDE3535),
                        ),
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: list.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return LabelDisplay(
                                  label: list[index], isSelect: true);
                            }),
                      )
                    ],
                  ),
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
