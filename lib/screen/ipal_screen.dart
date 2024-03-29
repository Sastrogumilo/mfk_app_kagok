import 'package:flutter/material.dart';

class IpalScreen extends StatefulWidget {
  const IpalScreen({super.key});

  @override
  State<IpalScreen> createState() => _IpalScreenState();
}

class _IpalScreenState extends State<IpalScreen> {
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
                  'Ini Ipal Screen',
                ),
              ],
            ),
          ),
        ));
  }
}
