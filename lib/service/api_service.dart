import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kagok_app/app_config.dart';
//import auth_response.dart
import 'package:kagok_app/model/response_model.dart';
import 'package:kagok_app/service/snack_bar_service.dart';

class APIService {
  static final String baseUrl = AppConfig.baseUrl;

  final Dio _dio = Dio();

  Future<AuthResponse<T>?> apiProvider<T>(
      {required BuildContext context,
      required String method,
      required String endpoint,
      required dynamic requestdata,
      required T Function(dynamic) model,
      bool showNotification = true}) async {
    try {
      String url = '$baseUrl$endpoint';

      //check url if has double slahes after http or
      //https and remove double slashes after http or https
      RegExp regex = RegExp(r'(?<!:)//+');

      String cleanUrl = url.replaceFirstMapped(regex, (match) => '/');

      //get token from shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token') ?? "1234";
      // String? token = "1234"; //test purpose only
      // print(token);
      final response = await _dio.request(
        cleanUrl,
        data: requestdata,
        options: Options(headers: {'token': token}, method: method),
      );

      // print(response.data);

      if (response.statusCode == 200) {
        final hasil = AuthResponse.fromJson(response.data, model);
        //snackbar for success
        if (context.mounted && endpoint != '/') {
          if (showNotification == true) {
            await showSnackBar(
                context: context,
                message: hasil.metadata.message,
                color: Colors.green,
                icon: Icons.check);
          }
        }

        return hasil;
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      // print(e);
      var responseData = e.response?.data;
      // print(responseData);

      if (responseData is String) {
        RegExp regex = RegExp(r'<!--\s*(.*?)\s*#0');
        Match? match = regex.firstMatch(responseData);

        responseData = {
          'response': [],
          'metadata': {
            'message': match?.group(1)?.contains('Symfony') ?? false
                ? match?.group(1)
                : "(${e.response?.statusCode}) Server Error, Please try again later or contact the administrator",
            'status': e.response?.statusCode ?? 500
          }
        };

        // print(responseData);
      }

      final authResponse = AuthResponse.fromJson(responseData, model);
      final errorMessage = authResponse.metadata.message;

      if (context.mounted) {
        await showSnackBar(
            context: context,
            color: Colors.red,
            icon: Icons.error,
            message: errorMessage);
      }

      return authResponse;
    }
  }
}
