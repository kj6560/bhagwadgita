import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/remote_services.dart';
import '../utility/values.dart';

class LoginController extends GetxController {
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void login(String email, String password, var context) async {
    try {
      print("reached login controller");
      var response = await RemoteServices.login(email, password);
      print(response);
      if (!response!['error']) {
        final prefs = await SharedPreferences.getInstance();

        final Map<String, dynamic> userObj = response['user'];

        prefs.setString("token", response['token']);
        prefs.setInt("id", userObj['id']);
        prefs.setString("email", userObj['email']);
        prefs.setString("name", userObj['name']);
        prefs.setString("image", userObj['image'] ?? "");
        prefs.setString("about", userObj['about'] ?? "");
        prefs.setInt("user_role", userObj['user_role'] ?? "");

        Get.offAllNamed("/home");
      } else {
        Values.showMsgDialog("Login", response['message'], context, () {
          Navigator.pop(context);
        });
      }
    } catch (e) {
      print(e);
      Values.showInternetErrorDialog("Login", e, context);
    }
  }
}
