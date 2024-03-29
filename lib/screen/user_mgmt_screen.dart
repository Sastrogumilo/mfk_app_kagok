import 'package:flutter/material.dart';

class UserMgmtScreen extends StatefulWidget {
  const UserMgmtScreen({super.key});

  @override
  State<UserMgmtScreen> createState() => _UserMgmtScreenState();
}

class _UserMgmtScreenState extends State<UserMgmtScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // title: const Text('Home Screen'),
            ),
        body: const SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Ini User Management Screen',
                ),
              ],
            ),
          ),
        ));
  }
}
