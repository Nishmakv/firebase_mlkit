import 'package:firebase_project/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class LanguageTranslationScreen extends StatefulWidget {
  const LanguageTranslationScreen({super.key});

  @override
  State<LanguageTranslationScreen> createState() =>
      _LanguageTranslationScreenState();
}

class _LanguageTranslationScreenState extends State<LanguageTranslationScreen> {
  String result = '';
  bool isPressed1 = true;
  bool isResult = false;
  bool isIcon = false;

  String dropdownValue = "Select Language";

  final _control = TextEditingController();

  Future texttranslate(String msg, dynamic lang) async {
    final modelManager = OnDeviceTranslatorModelManager();
    result = "";

    if (lang == 'Hindi') {
      final bool response =
          await modelManager.isModelDownloaded(TranslateLanguage.hindi.bcpCode);
      if (response == false) {
        final bool response1 =
            await modelManager.downloadModel(TranslateLanguage.hindi.bcpCode);
      } else {}
      // ignore: non_constant_identifier_names
      final Ondevicetranslator = OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.english,
          targetLanguage: TranslateLanguage.hindi);
      final String text = await Ondevicetranslator.translateText(msg);
      result += text;
      Ondevicetranslator.close();
    } else if (lang == 'Tamil') {
      final bool response =
          await modelManager.isModelDownloaded(TranslateLanguage.tamil.bcpCode);
      if (response == false) {
        final bool response1 =
            await modelManager.downloadModel(TranslateLanguage.tamil.bcpCode);
      } else {}
      // ignore: non_constant_identifier_names
      final Ondevicetranslator = OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.english,
          targetLanguage: TranslateLanguage.tamil);
      final String text = await Ondevicetranslator.translateText(msg);
      result += text;

      Ondevicetranslator.close();
    } else if (lang == 'Japanese') {
      final bool response = await modelManager
          .isModelDownloaded(TranslateLanguage.japanese.bcpCode);
      if (response == false) {
        final bool response1 = await modelManager
            .downloadModel(TranslateLanguage.japanese.bcpCode);
      } else {}
      // ignore: non_constant_identifier_names
      final Ondevicetranslator = OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.english,
          targetLanguage: TranslateLanguage.japanese);
      final String text = await Ondevicetranslator.translateText(msg);
      result += text;
      Ondevicetranslator.close();
    } else {
      final bool response = await modelManager
          .isModelDownloaded(TranslateLanguage.german.bcpCode);
      if (response == false) {
        final bool response1 =
            await modelManager.downloadModel(TranslateLanguage.german.bcpCode);
      } else {}
      // ignore: non_constant_identifier_names
      final Ondevicetranslator = OnDeviceTranslator(
          sourceLanguage: TranslateLanguage.english,
          targetLanguage: TranslateLanguage.german);
      final String text = await Ondevicetranslator.translateText(msg);

      result += text;

      Ondevicetranslator.close();
    }

    setState(() {
      isResult = true;
      isIcon = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Language Translation',
          style: TextStyle(color: Colors.black),
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
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Color(0xFFDE3535),
                  )),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: 'Type here',
                ),
                maxLines: 4,
              ),
              DropdownButton<String>(
                focusColor: Colors.blue,
                dropdownColor: const Color.fromARGB(255, 224, 225, 226),
                value: dropdownValue,
                elevation: 16,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>[
                  'Select Language',
                  'Tamil',
                  'Hindi',
                  'Japanese',
                  'German'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Button(
                onButtonTap: () async {
                  texttranslate(_control.text, dropdownValue);
                },
                text: 'Language Translation',
                isPress: isPressed1,
                isIcon: false,
              ),
              const SizedBox(height: 25),
              const SizedBox(width: 20),
              isResult == true
                  ? SizedBox(
                      // width: 300,
                      // height: 80,
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0x33DE3535), width: 1),
                              color: const Color(0x0CDE3535),
                            ),
                            child: Center(
                              child: Text(
                                result,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
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
