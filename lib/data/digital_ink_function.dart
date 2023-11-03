import 'package:google_ml_kit/google_ml_kit.dart';

class InkClass {
  Future recogniseText(language, ink) async {
    final digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');

    List<String> _recognisedpoints = [];

    final modelManager = DigitalInkRecognizerModelManager();
    final bool response = await modelManager.downloadModel(language);
    final candidates = await digitalInkRecognizer.recognize(ink);

    for (final candidate in candidates) {
      _recognisedpoints.add(candidate.text);
      // recognizedText += '\n${candidate.text}';
    }
    print(_recognisedpoints);
    return _recognisedpoints;
  }
}
