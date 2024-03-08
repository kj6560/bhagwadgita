import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/values.dart';


class RemoteServices {
  static Future<bool> hasInternet() async {
    return await InternetConnectionChecker().hasConnection;
  }

  static void showSnackBar(BuildContext context) async {
    if (!await RemoteServices.hasInternet()) {
      const snackBar = SnackBar(
        content: Text('No Internet!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  static var client = http.Client();

  static Future<Map<String, dynamic>?> login(
      String email, String password) async {
    var mBody = jsonEncode({'email': email, 'password': password});
    print(mBody);
    final response = await http.post(
      Uri.parse('${Values.baseUrl}/api/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: mBody,
    );

    final Map<String, dynamic> responseObject = json.decode(response.body);
    if (responseObject != null) {
      return responseObject;
    }
    return null;
  }


}
