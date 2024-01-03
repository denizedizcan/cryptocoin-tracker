import 'package:crypto_list/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // inital theme is light mode
  ThemeData _themeData = lightMode;

  // getter methode to access the theme from other parts of code
  ThemeData get themeData => _themeData;

  // getter methode to access is dark mode from other parts of code
  bool get isDarkMode => _themeData == darkMode;

  // setter method to set the new theme
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // function for toggle switch theme
  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
