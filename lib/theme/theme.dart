import 'package:flutter/material.dart';

ThemeData lightMode =ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFF7F9FC),
    primary: Colors.black,
    secondary: Colors.white,
  )
);

ThemeData darkMode = ThemeData(
brightness: Brightness.dark,
colorScheme: const ColorScheme.dark(
  background: Color(0xFF1E1E1E),
  primary: Color.fromARGB(255, 255, 255, 255),
  secondary:  Color(0xFF222222),
)
);