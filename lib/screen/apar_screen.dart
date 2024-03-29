import 'package:flutter/material.dart';

class AparScreen extends StatefulWidget {
  const AparScreen({super.key});

  @override
  State<AparScreen> createState() => _AparScreenState();
}

class _AparScreenState extends State<AparScreen> {
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
                  'Ini APAR Screen',
                ),
              ],
            ),
          ),
        ));
  }
}
