import 'package:flutter/material.dart';

class Mytheme {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    brightness: Brightness.light,
    primaryColor: Colors.amber[100],
    accentColor: Colors.amber[200],
    buttonColor: Colors.amber[500],
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    brightness: Brightness.light,
    primaryColor: Colors.amber[100],
    accentColor: Colors.amber[200],
    buttonColor: Colors.amber[500],
  );
}
