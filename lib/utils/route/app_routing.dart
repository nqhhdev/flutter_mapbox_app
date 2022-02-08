import 'package:clean_architechture/presentation/home/home_route.dart';
import 'package:clean_architechture/presentation/list_user/list_user_route.dart';
import 'package:clean_architechture/presentation/login/login_route.dart';
import 'package:flutter/material.dart';

enum RouteDefine {
  loginScreen,
  homeScreen,
  listUserScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.loginScreen.name: (_) => LoginRoute.route,
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
      RouteDefine.listUserScreen.name: (_) => ListUserRoute.route,
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
