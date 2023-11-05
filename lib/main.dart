import 'package:firebase_core/firebase_core.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_project/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

 await Firebase.initializeApp();

  final fcmToken =  await FirebaseMessaging.instance.getToken();
  
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme:
              const AppBarTheme(iconTheme: IconThemeData(color: Colors.black))),
      home: const HomePage(),
    );
  }
}