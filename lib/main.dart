import 'package:flutter/material.dart';
//import homescreen

import 'package:kagok_app/screen/splash_screen.dart';
import 'package:kagok_app/screen/login_screen.dart';
import 'package:kagok_app/screen/home_screen.dart';
import 'package:kagok_app/screen/ipal_screen.dart';
import 'package:kagok_app/screen/apar/apar_screen.dart';
import 'package:kagok_app/screen/user_mgmt_screen.dart';
import 'package:kagok_app/screen/gas_medik_screen.dart';
import 'package:kagok_app/screen/apar/apar_form_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  // runApp(const MyApp());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "OK",
    initialRoute: '/',
    routes: {
      '/': (context) => const SplashScreen(),
      '/login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
      '/ipal': (context) => const IpalScreen(),
      '/apar': (context) => const AparScreen(),
      '/apar/form': (context) => const AparFormScreen(),
      '/user_management': (context) => const UserMgmtScreen(),
      '/gas_medik': (context) => const GasMedikScreen(),
    },
  ));
}
