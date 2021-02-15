
import 'package:flutter/material.dart';
import 'package:flutter_app_bluestack/utils/memory_management.dart';





class ThemeProvider extends ChangeNotifier {
  // shared pref object

  bool _isDarkModeOn = false;

  bool get isDarkModeOn {
   _isDarkModeOn= MemoryManagement.isDarkMode;
   return _isDarkModeOn;
  }

  void updateTheme(bool isDarkModeOn) {
    MemoryManagement.changeTheme(isDarkModeOn);
    _isDarkModeOn=MemoryManagement.isDarkMode;

    notifyListeners();
  }
}
