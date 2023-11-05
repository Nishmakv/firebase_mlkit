import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:flutter/material.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/button.dart';

class BarcodeScreen extends StatefulWidget {
  const BarcodeScreen({super.key});

  @override
  State<BarcodeScreen> createState() => _BarcodeScreenState();
}

class _BarcodeScreenState extends State<BarcodeScreen> {
  XFile? image;
  ImagePicker? imagePicker;
  String text1 = "";
  bool isPressed1 = true;
  bool isResult = false;
  String? displayValue;

  Future pickImage(String a) async {
    image = await ImagePicker().pickImage(
        source: a == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    setState(() {
      getbarcode();
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
                  pickImage('Camera');
                  Navigator.pop(context);
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

  Future getbarcode() async {
    text1 = "";
    final inputImage = InputImage.fromFilePath(image!.path);
    final List<BarcodeFormat> formate = [BarcodeFormat.all];
    final barcodescanner = BarcodeScanner(formats: formate);
    final List<Barcode> code = await barcodescanner.processImage(inputImage);
    for (Barcode barcode in code) {
      final type = barcode.type;
      final String? displayValue = barcode.displayValue;
      switch (type) {
        case BarcodeType.wifi:
          final barcodeWifi = barcode.value as BarcodeWifi;
          print("r:$barcodeWifi");
          break;
        case BarcodeType.url:
          final barcodeUrl = barcode.value as BarcodeUrl;
          print("r:$barcodeUrl");
          break;
        default:
          break;
      }
      text1 += '${displayValue}';

      setState(() {
        isResult = true;
      });
    }
    barcodescanner.close();
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
       backgroundColor: Colors.white,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const BarcodeScreen(),
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
                          const SizedBox(height: 10),
                        
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
                        height: 80,
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0x33DE3535), width: 1),
                          color: const Color(0x0CDE3535),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Result',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            //Text(text1),
                            Text(text1 == "" ? "No barcode detected" : text1),
                          ],
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
