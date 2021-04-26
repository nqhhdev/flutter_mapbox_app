enum AppFlavor {
  Development,
  Staging,
  Production,
}

class AppConfig {
  final String apiBaseUrl;
  final AppFlavor appFlavor;

  AppConfig({
    required this.apiBaseUrl,
    required this.appFlavor,
  });

  static AppConfig? _instance;

  static AppConfig devConfig = AppConfig(
    apiBaseUrl: 'https://api.dev2.setel.my/api/',
    appFlavor: AppFlavor.Development,
  );

  static AppConfig stagingConfig = AppConfig(
    apiBaseUrl: 'https://api.staging2.setel.my/api/',
    appFlavor: AppFlavor.Staging,
  );

  static AppConfig productionConfig = AppConfig(
    apiBaseUrl: 'https://api.prod.setel.my/api/',
    appFlavor: AppFlavor.Production,
  );

  static AppConfig? getInstance({flavorName}) {
    if (_instance == null) {
      switch (flavorName) {
        case 'development':
          {
            _instance = devConfig;
          }
          break;
        case 'staging':
          {
            _instance = stagingConfig;
          }
          break;
        case 'production':
          {
            _instance = productionConfig;
          }
          break;
      }
      return _instance;
    }
    return _instance;
  }
}
