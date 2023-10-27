// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

// class TextFunction{
  
//    void detectText(image,text) async {
    
//     final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

//     final inputImage = InputImage.fromFilePath(image!.path);

//     final RecognizedText recognizedText =
//         await textRecognizer.processImage(inputImage);

//     for (TextBlock block in recognizedText.blocks) {
      
//         text += "${block.text}";
     
//     }
//     textRecognizer.close();
//   }
// }