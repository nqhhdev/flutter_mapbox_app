import 'package:clean_architechture/config/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static TextStyle get label40 {
    return TextStyle(
      fontSize: 40.sp,
    );
  }

  static TextStyle get label36 {
    return TextStyle(
      fontSize: 36.sp,
    );
  }

  static TextStyle get label30 {
    return TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle get label24 {
    return TextStyle(
      fontSize: 24.sp,
      fontWeight: FontWeight.w200,
    );
  }

  static TextStyle get label18 {
    return TextStyle(
      fontSize: 18.sp,
    );
  }

  static TextStyle get label16 {
    return TextStyle(
      fontSize: 16.sp,
    );
  }

  static TextStyle get buttonLabel {
    return TextStyle(
      fontSize: 20.sp,
      color: AppColors.blue,
    );
  }
}
