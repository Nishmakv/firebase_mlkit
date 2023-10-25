import 'package:firebase_project/screens/digital_ink.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';
import 'package:google_mlkit_entity_extraction/google_mlkit_entity_extraction.dart';

class LanguageDetector extends StatefulWidget {
  const LanguageDetector({super.key});

  @override
  State<LanguageDetector> createState() => _LanguageDetectorState();
}

class _LanguageDetectorState extends State<LanguageDetector> {
  String result = '';
  String result1 = '';
  bool isClicked = false;

  Future detectLanguage(String text) async {
    print(text);
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);

    final List<IdentifiedLanguage> possibleLanguages =
        await languageIdentifier.identifyPossibleLanguages(text);
    setState(() {
      result = '';
      result1 = '';
    });

    for (IdentifiedLanguage identify in possibleLanguages) {
      String language = identify.languageTag;
      var confidence = identify.confidence;
      result += '$language';
      result1 += '$confidence';

      switch (language) {
        case 'en':
          {
            setState(() {
              result = 'en(English)';
              result1 = '$confidence';
              isClicked = true;
              // result += 'en(English)+$confidence';
            });
          }
          break;
        case 'ja':
          {
            setState(() {
              result = 'ja(Japanade)';
              result1 = '$confidence';
              isClicked = true;
            });
          }
          break;
        case 'ch':
          {
            setState(() {
              result = 'ch(Chinese)';
              result1 = '$confidence';
              isClicked = true;
            });
          }
          break;
        case 'kr':
          {
            setState(() {
              result = 'kr(Korean)';
              result1 = '$confidence';
              isClicked = true;
            });
          }
      }
    }

    setState(() {});
  }

  final _control = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      detectLanguage(_control.text);
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (ctx) => SignatureCanvas()));
                      ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ));
                    },
                    child: const Text('Language Detection'),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              isClicked == true
                  ? Container(
                      width: 300,
                      height: 80,
                      child: Card(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text('Detected language:'),
                                Text(result),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Confidence score:'),
                                Text(result1),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
