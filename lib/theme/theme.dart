import 'package:flutter/material.dart';

// light mode
ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.blueGrey.shade300,
    primary: Colors.blueGrey.shade400,
    secondary: Colors.blueGrey.shade500,
    inversePrimary: Colors.blueGrey.shade900,
  ),
);

// dark mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.blueGrey.shade900,
    primary: Colors.blueGrey.shade800,
    secondary: Colors.blueGrey.shade700,
    inversePrimary: Colors.blueGrey.shade300,
  ),
);
