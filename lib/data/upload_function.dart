import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploader{
   XFile? image;

  Future pickImage(String a) async {
    image = await ImagePicker().pickImage(
        source: a == "Gallery" ? ImageSource.gallery : ImageSource.camera);
    
  }
  


}