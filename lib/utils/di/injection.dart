import 'package:clean_architechture/config/app_config.dart';
import 'package:clean_architechture/config/theme.dart';
import 'package:clean_architechture/data/login/data_sources/remote/login_api.dart';
import 'package:clean_architechture/data/login/repositories/login_repository_impl.dart';
import 'package:clean_architechture/data/utils/shared_pref_manager.dart';
import 'package:clean_architechture/domain/login/repositories/login_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

GetIt getIt = GetIt.instance;

Future setupInjection() async {
  await _registerAppComponents();
  await _registerNetworkComponents();
  _registerRepository();
}

Future _registerAppComponents() async {
  final sharedPreferencesManager = await SharedPreferencesManager.getInstance();
  getIt.registerSingleton<SharedPreferencesManager>(sharedPreferencesManager!);

  final appTheme = AppTheme();
  getIt.registerSingleton(appTheme);
}

Future<void> _registerNetworkComponents() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.getInstance()!.apiBaseUrl,
      connectTimeout: 10000,
    ),
  );
  dio.interceptors.addAll(
    [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
      ),
    ],
  );
  getIt.registerSingleton(dio);

  getIt
      .registerSingleton(LoginApi(dio, baseUrl: dio.options.baseUrl + 'user/'));
}

void _registerRepository() {
  getIt.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(
      getIt<LoginApi>(),
    ),
  );
}
