import 'package:flutter/material.dart';

class AppTheme {
  static const Color seed = Color(0xFF5B6CFF);

  static ThemeData light() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
      );
}