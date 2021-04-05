import 'package:clean_architechture/config/navigation_util.dart';
import 'package:clean_architechture/utils/route/app_routing.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/app_config.dart';
import 'generated/l10n.dart';
import 'utils/di/injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Listen for flavor triggered by iOS / android build
  await const MethodChannel('flavor').invokeMethod<String>('getFlavor').then(
    (String flavor) async {
      final appConfig = AppConfig.getInstance(flavorName: flavor);
      print("App Config : ${appConfig.apiBaseUrl}");
    },
  ).catchError(
    (error) {
      AppConfig.getInstance(flavorName: "development");

      print("Error when set up enviroment $error");
    },
  );

  await setupInjection();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      navigatorKey: NavigationUtil.rootKey,
      debugShowCheckedModeBanner: false,
      initialRoute: RouteDefine.LoginScreen.name,
      onGenerateRoute: AppRouting.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "RaleWay",
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 42.0, fontWeight: FontWeight.bold),
          headline2: TextStyle(fontSize: 36.0, fontStyle: FontStyle.normal),
          bodyText2: TextStyle(fontSize: 33.0),
          // Using Text Theme with Theme.of(context).textTheme.bodyText2,
        ),
      ),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
