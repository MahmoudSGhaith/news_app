
import 'package:flutter/material.dart';

class ConfigProvider extends ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.dark;
  bool get isLight => currentTheme == ThemeMode.light;
  void changeAppTheme(ThemeMode newTheme){
    if(currentTheme == newTheme) return;
    currentTheme = newTheme;
    notifyListeners();
  }

  String currentLanguage = "en";
  bool get isEnglish => currentLanguage == "en";
  void changeAppLanguage(String newLanguage){
    if(currentLanguage == newLanguage) return;
    currentLanguage = newLanguage;
    notifyListeners();
  }
}