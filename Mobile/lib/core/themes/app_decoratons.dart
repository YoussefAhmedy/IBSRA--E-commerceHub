import 'package:flutter/material.dart';

class AppDecorations {
  static const homePageHeroDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFF43F5E), // from (#f43f5e)
        Color(0xFFEC4899), // to (#ec4899)
      ],
    ),
  );
}
