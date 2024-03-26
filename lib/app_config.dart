enum Environment { development, production }

class AppConfig {
  static Environment currentEnvironment = Environment.development;
  // static Environment currentEnvironment = Environment.production;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.production:
        return 'https://production-url.com';
      case Environment.development:
      default:
        return 'http://192.168.70.72:8000/api/';
    }
  }
}
