import 'package:flutter/material.dart';
//import homescreen

import 'package:kagok_app/screen/splash_screen.dart';
import 'package:kagok_app/screen/login_screen.dart';
import 'package:kagok_app/screen/home_screen.dart';
import 'package:kagok_app/screen/ipal_screen.dart';
import 'package:kagok_app/screen/apar_screen.dart';
import 'package:kagok_app/screen/user_mgmt_screen.dart';
import 'package:kagok_app/screen/gas_medik_screen.dart';

void main() {
  // runApp(const MyApp());
  runApp(MaterialApp(
    title: "OK",
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
      '/ipal': (context) => const IpalScreen(),
      '/apar': (context) => const AparScreen(),
      '/user_management': (context) => const UserMgmtScreen(),
      '/gas_medik': (context) => const GasMedikScreen(),
    },
  ));
}
