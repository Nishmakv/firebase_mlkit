import 'package:firebase_project/data/language_list.dart';
import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

class LanguageClass {
  Future<List<Data>> detectLanguage(String text) async {
    String result = '';
    String result1 = '';
    List<Data> list = [];
    final languageIdentifier = LanguageIdentifier(confidenceThreshold: 0.5);

    final List<IdentifiedLanguage> possibleLanguages =
        await languageIdentifier.identifyPossibleLanguages(text);

    for (IdentifiedLanguage identify in possibleLanguages) {
      String language = identify.languageTag;
      var confidence = identify.confidence;

      switch (language) {
        case 'en':
          {
            result = 'en(English)';
            result1 = '$confidence';
          }
          break;
        case 'ja':
          {
            result = 'ja(Japanese)';
            result1 = '$confidence';
          }
          break;
        case 'ch':
          {
            result = 'ch(Chinese)';
            result1 = '$confidence';
          }
          break;
        case 'kr':
          {
            result = 'kr(Korean)';
            result1 = '$confidence';
          }
      }
      list.add(Data(result: result, result1: result1));
    }
    return list;
  }
}
