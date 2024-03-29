import 'package:kagok_app/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import model
import 'package:kagok_app/model/login_model.dart';

class LoginController {
  Future login(BuildContext context, String username, String password) async {
    final data = await APIService().apiProvider(
        context: context,
        method: "POST",
        endpoint: "/login",
        requestdata: {"username": username, "password": password},
        model: (json) => UserLoginModel.fromJson(json),
        showNotification: true);

    if (data?.metadata.status == 200) {
      //save to shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data!.response.token);
      prefs.setString("username", data.response.username);
      prefs.setString("puskesmas", data.response.puskesmas);
      prefs.setString("id", data.response.id.toString());
      prefs.setString("isAdmin", data.response.isAdmin.toString());
      prefs.setString("nama", data.response.nama.toString());
      prefs.setStringList("menu", data.response.menu);

      //redirect to home
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    }

    return true;
  }
}
