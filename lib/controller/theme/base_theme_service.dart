import 'package:chat/controller/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:chat/controller/theme/backend_types.dart';

import 'package:chat/controller/theme/theme_types.dart';

abstract class AppTheme extends ChangeNotifier {
  ThemeType themeType;

  bool useSystem;

  AppTheme({
    this.themeType = ThemeType.LIGHT,
    this.useSystem = true,
  }) : super() {
    loadSettings();
  }

  void setThemeType(ThemeType type) {
    themeType = type;
    saveSettings();
    notifyListeners();
  }

  void setUseSystem(bool val) {
    useSystem = val;
    saveSettings();
    notifyListeners();
  }

  ThemeData getCustomTheme() {
    switch (themeType) {
      case ThemeType.LIGHT:
        return lightTheme;
      case ThemeType.DARK:
        return darkTheme;
      default:
        return lightTheme;
    }
  }

  ThemeData getLightTheme() {
    if (useSystem) {
      return lightTheme;
    } else {
      return getCustomTheme();
    }
  }

  ThemeData getDarkTheme() {
    if (useSystem) {
      return darkTheme;
    } else {
      return getCustomTheme();
    }
  }

  ThemeBackendType getRequiredService();

  Future<void> loadSettings();

  Future<void> saveSettings();
}
