import 'package:flutter/material.dart';
//import homescreen

import 'package:kagok_app/screen/splash_screen.dart';
import 'package:kagok_app/screen/login_screen.dart';
import 'package:kagok_app/screen/home_screen.dart';

void main() {
  // runApp(const MyApp());
  runApp(MaterialApp(
    title: "OK",
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
    },
  ));
}
