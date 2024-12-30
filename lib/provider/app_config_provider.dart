import 'package:flutter/material.dart';

class AppConfigProvider extends ChangeNotifier {
  ThemeMode appMode = ThemeMode.light;
  String appLanguage = 'english';
  void changeLanguage(String newLanguage) {
    if (appLanguage != newLanguage) {
      appLanguage = newLanguage;
      notifyListeners();
    }
  }

  void changeTheme(ThemeMode newTheme) {
    if (appMode != newTheme) {
      appMode = newTheme;
      notifyListeners();
    }
  }
}
