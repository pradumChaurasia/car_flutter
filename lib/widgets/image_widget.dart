import 'dart:convert';
import 'package:flutter/material.dart';

class Base64ImageWidget extends StatelessWidget {
  final String base64Image;

  Base64ImageWidget({required this.base64Image});

  @override
  Widget build(BuildContext context) {
    if (base64Image.isNotEmpty) {
      final decodedBytes = base64Decode(base64Image);
      return Image.memory(decodedBytes);
    } else {
      // Return a placeholder or empty container if base64Image is empty or null
      return Container();
    }
  }
}
