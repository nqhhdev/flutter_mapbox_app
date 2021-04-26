import 'package:clean_architechture/config/theme.dart';
import 'package:clean_architechture/generated/l10n.dart';
import 'package:clean_architechture/utils/di/injection.dart';
import 'package:clean_architechture/utils/route/app_routing.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

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
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Text(
            "Aspect Ratio : ${ScreenUtil().pixelRatio}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            S.current.title("Hoang"),
            style: Theme.of(context).textTheme.bodyText2,
          ),
          OutlinedButton(
            onPressed: () {
              _getSizes();
            },
            child: Text(
              "Get Size",
              style: Theme.of(context).textTheme.button,
            ),
          ),
          OutlinedButton(
            onPressed: () {
              getIt<AppTheme>().changeTheme();
            },
            child: Text(
              "Change Theme",
              style: Theme.of(context).textTheme.button,
            ),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, RouteDefine.ListUserScreen.name);
            },
            child: Text(
              "Move To List User Screen",
              style: Theme.of(context).textTheme.button,
            ),
          ),
        ],
      ),
    );
  }

  void _getSizes() {
    final renderBoxRed = _keyRed.currentContext!.findRenderObject();
    final sizeRed = renderBoxRed!.paintBounds.size;
    print("SIZE of Red: $sizeRed");
    setState(() {
      containerSize = sizeRed.toString();
    });
  }
}
