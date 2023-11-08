import 'package:firebase_project/data/digital_ink_function.dart';
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
  List<String> _recognizedPoints = [];

  bool isPressed1 = false;
  bool isPressed2 = false;
  bool isEmpty = true;
  bool isData = false;
  InkClass data = InkClass();

  @override
  void dispose() {
    _digitalInkRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            GestureDetector(
              onPanStart: (DragStartDetails details) {
                ink.strokes.add(Stroke());
              },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  isData = true;
                  isEmpty = false;
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
              child: Container(
                width: 330,
                height: 300,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xFFDE3535),
                  ),
                ),
                child: CustomPaint(
                  //widget used to give colour to the drawing.
                  painter: Signature(ink: ink),
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (ink.strokes.isNotEmpty) {
                          _recognizedPoints =
                              await data.recogniseText(language, ink);

                          setState(() {});
                        } else {
                          // null;
                          const snackBar = SnackBar(
                            content: Text('Your canvas is empty'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 55,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: isEmpty
                              ? const Color(0xFFF6F6F6)
                              : const Color(0xFFDE3535),
                        ),
                        child: Center(
                          child: Text(
                            'Detect Text',
                            style: TextStyle(
                              color: isEmpty ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _clearPad,
                      child: Container(
                        height: 55,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          color: isEmpty
                              ? const Color(0xFFF6F6F6)
                              : const Color(0xFFDE3535),
                        ),
                        child: Center(
                          child: Text(
                            'Clear Pad',
                            style: TextStyle(
                              color: isEmpty ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (_recognizedPoints.isNotEmpty)
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: const Color.fromARGB(5, 222, 54, 54),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Result',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Row(
                                  children: [
                                    const Text(
                                      '• ',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Expanded(
                                      child: Text(
                                        _recognizedPoints[index],
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
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
      isEmpty = true;

      _recognizedPoints.clear();
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
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0; //to control the text weight

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
