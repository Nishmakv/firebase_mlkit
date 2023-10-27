import 'package:firebase_project/data/upload_function.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TextScreen extends StatefulWidget {
   const TextScreen({super.key});
  

  @override
  State<TextScreen> createState() => _TextScreenState();
  
}

class _TextScreenState extends State<TextScreen> {
  XFile? image;
  ImageUploader imageuploader = ImageUploader();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Text Recognition',
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
      body: const SafeArea(
        child: SingleChildScrollView(
        child : Column(
         
        )
      )),
    );
  }

  
}
