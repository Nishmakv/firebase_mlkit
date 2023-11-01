import 'package:firebase_project/screens/barcode_screen.dart';
import 'package:firebase_project/screens/device_translation_screen.dart';
import 'package:firebase_project/screens/face_detection_screen.dart';
import 'package:firebase_project/screens/image_labelling.dart';
import 'package:firebase_project/screens/object_detection_screen.dart';
import 'package:firebase_project/screens/smart_reply.dart';
import 'package:firebase_project/screens/digital_ink.dart';
import 'package:firebase_project/screens/language_detector_screen.dart';
import 'package:firebase_project/screens/text_recognition_screen.dart';
// import 'package:firebase_project/widgets/button.dart';
// import 'package:firebase_project/widgets/home.dart';
import 'package:firebase_project/widgets/home_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/data/list.dart';

class GridScreen extends StatelessWidget {
  const GridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        crossAxisSpacing: 40,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, index) {
        return HomeButtonScreen(
          color: list1[index].color,
          icon: list1[index].icon,
          name: list1[index].name,
          onTapButton: () {
            switch (index) {
              case 0:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const BarcodeScreen(),
                  ),
                );

                break;
              case 1:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const LanguageTranslationScreen(),
                  ),
                );

                break;
              case 2:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ImageLabellingScreen(),
                  ),
                );

                break;
              case 3:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const FaceScreen(),
                  ),
                );
                break;
              case 4:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ObjectDetectionScreen(),
                  ),
                );

                break;
              case 5:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SmartReplyScreen(),
                  ),
                );

                break;
              case 6:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const TextScreen(),
                  ),
                );

                break;
              case 7:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SignatureCanvas(),
                  ),
                );

                break;
              case 8:
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const LanguageDetector(),
                  ),
                );

                break;
            }
          },
        );
      },
      itemCount: list1.length,
    );
  }
}
