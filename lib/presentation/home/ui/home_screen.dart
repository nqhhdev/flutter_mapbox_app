import 'package:clean_architechture/config/styles.dart';
import 'package:clean_architechture/config/theme.dart';
import 'package:clean_architechture/utils/di/injection.dart';
import 'package:clean_architechture/utils/multi-languages/multi_languages_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey _keyRed = GlobalKey();
  String containerSize = "";

  String get _containerSize =>
      containerSize.isNotEmpty ? "Container Width Height : $containerSize" : "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            key: _keyRed,
            width: 375.w,
            height: 500.h,
            color: Colors.red,
            child: Text(
              "Screen Width : ${ScreenUtil().screenWidth}  Height : ${ScreenUtil().screenHeight}"
              "\n$_containerSize "
              "\nWidth Ratio : ${ScreenUtil().scaleWidth} "
              "\nHeight Ratio : ${ScreenUtil().scaleHeight} "
              "\nText Ratio : ${ScreenUtil().scaleText} "
              "\n$defaultTargetPlatform",
              style: AppTextStyle.label30,
            ),
          ),
          Text(
            "Aspect Ratio : ${ScreenUtil().pixelRatio}",
            style: AppTextStyle.label30,
          ),
          Text(
            LocaleKeys.msg.tr(
              namedArgs: {"userName": "Hoang"},
              args: ["All"],
            ),
            style: AppTextStyle.label30,
          ),
          OutlinedButton(
            onPressed: () {
              _getSizes();
            },
            child: Text(
              "Get Size",
              style: AppTextStyle.label30,
            ),
          ),
          OutlinedButton(
            onPressed: () {
              getIt<AppTheme>().changeTheme();
            },
            child: Text(
              "Change Theme",
              style: AppTextStyle.label30,
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text(
              "Move To List User Screen",
              style: AppTextStyle.label30,
            ),
          ),
        ],
      ),
    );
  }

  void _getSizes() {
    final renderBoxRed = _keyRed.currentContext!.findRenderObject();
    final sizeRed = renderBoxRed!.paintBounds.size;
    setState(() {
      containerSize = sizeRed.toString();
    });
  }
}
