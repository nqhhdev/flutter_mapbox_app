import 'package:clean_architechture/config/colors.dart';
import 'package:clean_architechture/config/styles.dart';
import 'package:clean_architechture/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: FontFamily.raleway,
      textTheme: _lightTextTheme,
      primaryTextTheme: _lightTextTheme,
      accentTextTheme: _darkTextTheme,
      backgroundColor: AppColors.white,
      scaffoldBackgroundColor: AppColors.white,
      brightness: Brightness.light,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: Colors.blue,
      textTheme: _darkTextTheme,
      fontFamily: FontFamily.raleway,
      backgroundColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.black,
      brightness: Brightness.dark,
    );
  }

  static TextTheme get _lightTextTheme {
    return TextTheme(
      headline5: AppTextStyle.label1,
      headline6: AppTextStyle.label2,
      bodyText1: AppTextStyle.label3,
      bodyText2: AppTextStyle.label4,
      subtitle1: AppTextStyle.label5,
      subtitle2: AppTextStyle.label6,
      button: AppTextStyle.buttonLabel,
      // Using Text Theme with Theme.of(context).textTheme.bodyText2,
      //We using text theme from headline5 because of default color of headline 1-4 not exactly like black or white
    );
  }

  static TextTheme get _darkTextTheme {
    return TextTheme(
      headline5: AppTextStyle.label1,
      headline6: AppTextStyle.label2,
      bodyText1: AppTextStyle.label3,
      bodyText2: AppTextStyle.label4,
      subtitle1: AppTextStyle.label5,
      subtitle2: AppTextStyle.label6,
      button: AppTextStyle.buttonLabel,
      // Using Text Theme with Theme.of(context).textTheme.bodyText2,
      //We using text theme from headline5 because of default color of headline 1-4 not exactly like black or white
    );
  }
}
