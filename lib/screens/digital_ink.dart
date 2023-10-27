import 'package:firebase_project/data/digital_ink_function.dart';
import 'package:firebase_project/widgets/button.dart';
import 'package:flutter/material.dart' hide Ink;
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_digital_ink_recognition/google_mlkit_digital_ink_recognition.dart';

class SignatureCanvas extends StatefulWidget {
  const SignatureCanvas({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignatureCanvasState createState() => _SignatureCanvasState();
}

class _SignatureCanvasState extends State<SignatureCanvas> {
  final String language = 'en';
  final _digitalInkRecognizer = DigitalInkRecognizer(languageCode: 'en');
  final Ink ink = Ink();
  List<StrokePoint> _points = [];
  String _recognizedText = '';
  bool isPressed1 = false;
  bool isPressed2 = false;
  InkClass data = InkClass();

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Digital Ink Recognition',
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
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Button(
                      onButtonTap: () async {
                        // data.recogniseText(language, ink);

                        // showDialog(
                        //   context: context,
                        //   builder: (context) => const AlertDialog(
                        //     title: Text('Recognizing'),
                        //   ),
                        //   barrierDismissible: true,
                        // );
                        _recognizedText =
                            await data.recogniseText(language, ink);
                        setState(
                          () {
                            isPressed1 = true;
                            isPressed2 = false;
                          },
                        );
                      },
                      //onButtonTap: _recogniseText,
                      text: 'Detect Text',
                      isPress: isPressed1,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Button(
                        onButtonTap: _clearPad,
                        text: 'Clear Pad',
                        isPress: isPressed2),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onPanStart: (DragStartDetails details) {
                  ink.strokes.add(Stroke());
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    final RenderObject? object = context.findRenderObject();
                    final localPosition = (object as RenderBox?)
                        ?.globalToLocal(details.localPosition);
                    if (localPosition != null) {
                      _points = List.from(_points)
                        ..add(StrokePoint(
                          x: localPosition.dx,
                          y: localPosition.dy,
                          t: DateTime.now().millisecondsSinceEpoch,
                        ));
                    }
                    if (ink.strokes.isNotEmpty) {
                      ink.strokes.last.points = _points.toList();
                    }
                  });
                },
                onPanEnd: (DragEndDetails details) {
                  _points.clear();
                  setState(() {});
                },
                child: CustomPaint(
                  painter: Signature(ink: ink),
                  size: Size.infinite,
                ),
              ),
            ),
            if (_recognizedText.isNotEmpty)
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: const Color.fromARGB(5, 222, 54, 54),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Candidates',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            child: Text(_recognizedText),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ))
          ],
        ),
      ),
    );
  }

  void _clearPad() {
    setState(() {
      ink.strokes.clear();
      _points.clear();
      _recognizedText = '';
      isPressed1 = false;
      isPressed2 = true;
    });
  }
}

class Signature extends CustomPainter {
  Ink ink;

  Signature({required this.ink});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0;

    for (final stroke in ink.strokes) {
      for (int i = 0; i < stroke.points.length - 1; i++) {
        final p1 = stroke.points[i];
        final p2 = stroke.points[i + 1];
        canvas.drawLine(Offset(p1.x.toDouble(), p1.y.toDouble()),
            Offset(p2.x.toDouble(), p2.y.toDouble()), paint);
      }
    }
  }

  @override
  bool shouldRepaint(Signature oldDelegate) => true;
}
