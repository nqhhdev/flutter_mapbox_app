import 'package:clean_architechture/presentation/home/home_route.dart';
import 'package:clean_architechture/presentation/location/location_route.dart';
import 'package:clean_architechture/presentation/splash_screen/splash_route.dart';
import 'package:flutter/material.dart';

enum RouteDefine {
  splashScreen,
  homeScreen,
  locationScreen,
}

class AppRouting {
  static MaterialPageRoute generateRoute(RouteSettings settings) {
    final routes = <String, WidgetBuilder>{
      RouteDefine.homeScreen.name: (_) => HomeRoute.route,
      RouteDefine.splashScreen.name:(_) =>  SplashRoute.route,
      RouteDefine.locationScreen.name:(_) => LocationRoute.route,
    };

    final routeBuilder = routes[settings.name];

    return MaterialPageRoute(
      builder: (context) => routeBuilder!(context),
      settings: RouteSettings(name: settings.name),
    );
  }
}
