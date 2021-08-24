import 'package:clean_architechture/config/navigation_util.dart';
import 'package:clean_architechture/config/theme.dart';
import 'package:clean_architechture/main.dart';
import 'package:clean_architechture/utils/route/app_routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization_loader/easy_localization_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

class TestUtility {
  /// Wrap child widget with [MaterialApp] widget and localization.
  static Future createTestableWidget(WidgetTester tester,
      {Widget? child}) async {
    await tester.pumpWidget(TestWidgetWrapper(child: child));

    await tester.idle();
    // The async delegator load will require build on the next frame. Thus, pump
    await tester.pumpAndSettle();
  }

  static void setTestSizeTablet(WidgetTester tester) {
    tester.binding.window.physicalSizeTestValue = const Size(2048, 2732);
    tester.binding.window.devicePixelRatioTestValue = 2.0;
  }

  static void clearTestSize(WidgetTester tester) {
    tester.binding.window.clearPhysicalSizeTestValue();
    tester.binding.window.clearDevicePixelRatioTestValue();
  }
}

/// Wrapper for wrapping widget in Material App.
/// This will avoid UI exception when running widget.
class TestWidgetWrapper extends StatelessWidget {
  final Widget? child;

  const TestWidgetWrapper({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('vi', 'VN')],
      fallbackLocale: const Locale('en', 'US'),
      path: 'resources/langs/langs.csv',
      assetLoader: CsvAssetLoader(),
      child: ScreenUtilInit(
        designSize: const Size(400, 800),
        builder: () => MaterialApp(
          title: 'Flutter Demo',
          navigatorObservers: <NavigatorObserver>[
            MyApp.observer,
          ],
          navigatorKey: NavigationUtil.rootKey,
          debugShowCheckedModeBanner: false,
          initialRoute: RouteDefine.loginScreen.name,
          onGenerateRoute: AppRouting.generateRoute,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
        ),
      ),
    );
  }
}
