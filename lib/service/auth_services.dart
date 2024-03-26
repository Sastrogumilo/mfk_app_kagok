import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
//import app_config.dart
import 'package:kagok_app/app_config.dart';
//import auth_response.dart
import 'package:kagok_app/model/response_model.dart';

class ApiClient {
  static final String baseUrl = AppConfig.baseUrl;

  final Dio _dio = Dio();

  //check session storage for token key

  Future<AuthResponse?> checkAuth(BuildContext context) async {
    try {
      final String url = '${baseUrl}check_auth';
      // print('url: $url');
      final response = await _dio.post(
        url,
        options: Options(
          headers: {'token': "12345"},
        ),
      );

      if (response.statusCode == 200) {
        return AuthResponse.fromJson(response.data, (json) => json);
      } else {
        throw Exception('Failed to load data');
      }
    } on DioException catch (e) {
      // print('======================================');
      // print(e.response);

      final responseData = e.response?.data;
      final authResponse = AuthResponse.fromJson(responseData, (json) => json);
      final errorMessage = authResponse.metadata.message;

      if (context.mounted) {
        await ScaffoldMessenger.of(context)
            .showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 30),
                    Expanded(child: Text(errorMessage))
                  ],
                ),

                width: 300,
                backgroundColor: Colors.red, // Set background color to red
                shape: RoundedRectangleBorder(
                  // Apply rounded corners
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation:
                    1000, // Set elevation to make it appear as a floating card
                showCloseIcon: true,
                behavior: SnackBarBehavior.floating,
              ),
            )
            .closed
            .then((reason) {
          // No reason
        });
      }

      return authResponse;
      // throw Exception('Failed to connect to the server');
    }
    // catch (e) {
    //   throw Exception('Failed to connect to the server');
    // }
  }
}
