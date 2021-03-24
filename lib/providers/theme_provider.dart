import 'package:flutter/material.dart';

class ThemeChangeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeChangeProvider(this._themeData);

  ThemeData get getTheme => _themeData;

  set setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
