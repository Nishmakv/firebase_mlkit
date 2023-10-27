import 'package:google_ml_kit/google_ml_kit.dart';

class InkClass {
  Future recogniseText(language, ink) async {
    final digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
    String recognizedText = '';
    // final String language = 'en';
    // final Ink ink = Ink();
    final modelManager = DigitalInkRecognizerModelManager();
    final bool response = await modelManager.downloadModel(language);
    final candidates = await digitalInkRecognizer.recognize(ink);
    recognizedText = '';
    for (final candidate in candidates) {
      recognizedText += '\n${candidate.text}';
    }
    return recognizedText;
  }
}
