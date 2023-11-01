import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/widgets/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isResult = false;
  String? displayValue;

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
        isPressed1 = true;
        isPressed2 = true;
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
                          Container(
                            width: 350,
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
                          const SizedBox(width: 5),
                          SizedBox(
                            height: 50,
                            width: 150,
                            child: Button(
                              onButtonTap: getbarcode,
                              text: "Barcode Scanner",
                              isPress: isPressed2,
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 20),
                isResult == true
                    ? Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color(0x33DE3535), width: 1),
                          color: const Color(0x0CDE3535),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
