import 'package:flutter/material.dart';

class CardsModel {
  Color? color;
  Icon? icon;
  String name;

  CardsModel({required this.color, required this.icon, required this.name});
}

List<CardsModel> list1 = [
  CardsModel(
      color: const Color.fromARGB(255, 68, 133, 253),
      icon: const Icon(
        Icons.join_left,
        color: Colors.white,
        size: 30,
      ),
      name: 'Barcode Scanning'),
  CardsModel(
      color: const Color.fromARGB(255, 165, 132, 255),
      icon: const Icon(
        Icons.shutter_speed,
        size: 30,
        color: Colors.white,
      ),
      name: 'Device Translation'),
  CardsModel(
      color: const Color.fromARGB(255, 255, 120, 84),
      icon: const Icon(
        Icons.wallpaper,
        size: 30,
        color: Colors.white,
      ),
      name: 'Image Detection'),
  CardsModel(
      color: const Color.fromARGB(255, 254, 167, 37),
      icon: const Icon(
        Icons.add_reaction,
        size: 30,
        color: Colors.white,
      ),
      name: 'Face Detection'),
  CardsModel(
      color: const Color.fromARGB(255, 0, 204, 106),
      icon: const Icon(
        Icons.photo_size_select_large,
        size: 30,
        color: Colors.white,
      ),
      name: 'Object Detection'),
  CardsModel(
      color: const Color.fromARGB(255, 0, 201, 228),
      icon: const Icon(
        Icons.note_add_outlined,
        color: Colors.white,
        size: 30,
      ),
      name: 'Smart reply'),
  CardsModel(
      color: const Color.fromARGB(255, 253, 68, 179),
      icon: const Icon(
        Icons.format_shapes,
        color: Colors.white,
        size: 30,
      ),
      name: 'Text Recognition'),
  CardsModel(
      color: const Color.fromARGB(255, 253, 68, 68),
      icon: const Icon(
        Icons.draw,
        color: Colors.white,
        size: 30,
      ),
      name: 'Digital Ink Recognition'),
  CardsModel(
      color: const Color.fromARGB(255, 184, 209, 134),
      icon: const Icon(
        Icons.language,
        color: Colors.white,
        size: 30,
      ),
      name: 'Languade Identification'),
];
