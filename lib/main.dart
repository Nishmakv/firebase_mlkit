import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/screens/image_add_screen.dart';
import 'package:firebase_project/widgets/in_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  // final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // print(analytics);

  // final FirebaseInAppMessaging fian = FirebaseInAppMessaging.instance;
  // print(fian);
 // PushNotificationService().initailize(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const ImageAddScreen(),
    );
  }
}
