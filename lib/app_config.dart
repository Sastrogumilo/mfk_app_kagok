import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { development, production, developmentThethering }

class AppConfig {
  // static Environment currentEnvironment = Environment.development;
  // static Environment currentEnvironment = Environment.developmentThethering;
  static Environment currentEnvironment = Environment.production;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.production:
        return dotenv.env['URL_PRODUCTION'].toString();
      case Environment.developmentThethering:
        return dotenv.env['URL_DEVELOPMENT_THETHERING'].toString();
      default:
        return dotenv.env['URL_DEVELOPMENT'].toString();
    }
  }
}
