enum Environment { development, production, developmentThethering }

class AppConfig {
  static Environment currentEnvironment = Environment.development;
  // static Environment currentEnvironment = Environment.developmentThethering;
  // static Environment currentEnvironment = Environment.production;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.production:
        return 'https://production-url.com';
      case Environment.developmentThethering:
        return "http://192.168.225.74:8000/api/";
      default:
        return 'http://192.168.70.72:8000/api/';
    }
  }
}
