import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  var themeMode = ThemeMode.light;
  //get getTheme => themeMode;
  setTheme(themeModeNew){
    themeMode = themeModeNew;
    notifyListeners();
  }
}