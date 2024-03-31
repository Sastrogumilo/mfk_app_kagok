import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:kagok_app/app_config.dart';

class UserMgmtScreen extends StatefulWidget {
  const UserMgmtScreen({super.key});

  @override
  State<UserMgmtScreen> createState() => _UserMgmtScreenState();
}

class _UserMgmtScreenState extends State<UserMgmtScreen> {
  @override
  Widget build(BuildContext context) {
    final String baseUrl = AppConfig.baseUrl;

    //remove /api in baseUrl
    final String url = baseUrl.replaceAll('/api', '');

    return Scaffold(
        appBar: AppBar(
            // title: const Text('Home Screen'),
            ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, left: 30.0, right: 30.0, bottom: 10.0),
                  child: const Icon(Icons.info, size: 50, color: Colors.blue),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, left: 30.0, right: 30.0, bottom: 10.0),
                  child: const Text(
                    "Pengumuman User Management",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 10, left: 30.0, right: 30.0, bottom: 10.0),
                  child: const Text(
                    'Kelihantannya anda mendapatkan akses menu untuk User Management, untuk keamanan data dianjurkan menambah, menganti dan menghapus hanya dapat diakses oleh admin',
                  ),
                ),
                GestureDetector(
                    onTap: () => {launchUrlString(url)},
                    child: Container(
                      margin: const EdgeInsets.only(
                          top: 10, left: 30.0, right: 30.0, bottom: 10.0),
                      child: const Text(
                        'Klik disini untuk membuka web panel ',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
