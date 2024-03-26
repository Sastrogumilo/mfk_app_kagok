import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:kagok_app/service/api_service.dart';
import 'package:kagok_app/model/test_server.dart';
import 'package:kagok_app/model/check_auth_model.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  Future<void> checkServerAndAuth(BuildContext context) async {
    // Check if the server is on
    await APIService()
        .apiProvider<TestServerModel>(
            context: context,
            method: 'GET',
            endpoint: '/',
            requestdata: {},
            model: (json) => TestServerModel.fromJson(json),
            showNotification: false)
        .then((value) {
      if (value?.metadata.status != 200) {
        SystemNavigator.pop(); // Close app if server is not reachable
        return;
      }
    });

    // Check authentication
    if (context.mounted) {
      await APIService()
          .apiProvider<CheckAuthModel>(
              context: context,
              method: 'POST',
              endpoint: '/check_auth',
              requestdata: {},
              model: (json) => CheckAuthModel.fromJson(json),
              showNotification: true)
          .then((hasil) {
        if (hasil?.metadata.status == 200) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
        // return hasil;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController();
    useEffect(() {
      // useEffect ensures that the asynchronous function runs only once
      // when the widget is first built
      // checkServerAndAuth(context);
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Lottie.asset(
              'assets/lottie/splash.json',
              controller: animationController,
              onLoaded: (composition) {
                animationController
                  ..duration = composition.duration
                  ..forward().whenComplete(() => checkServerAndAuth(context));
              },
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 20,
            bottom: 100,
            child:
                const CircularProgressIndicator(), // Use a placeholder widget
          ),
        ],
      ),
    );
  }
}
