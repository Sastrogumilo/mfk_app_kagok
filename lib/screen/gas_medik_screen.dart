import 'package:flutter/material.dart';

class GasMedikScreen extends StatefulWidget {
  const GasMedikScreen({super.key});

  @override
  State<GasMedikScreen> createState() => _GasMedikScreenState();
}

class _GasMedikScreenState extends State<GasMedikScreen> {
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
                  'Ini Gas Medik Screen',
                ),
              ],
            ),
          ),
        ));
  }
}
