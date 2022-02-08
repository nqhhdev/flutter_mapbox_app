import 'package:clean_architechture/data/utils/shared_pref_manager.dart';
import 'package:flutter/material.dart';

import '../config/theme.dart';
import 'di/injection.dart';

class SessionUtils {
  static bool get isDarkTheme =>
      getIt<AppTheme>().currentTheme == ThemeMode.dark;

  static void saveAccessToken(String accessToken) =>
      getIt<SharedPreferencesManager>().putString(
        SharedPreferenceKey.keyAccessToken,
        accessToken,
      );
}
