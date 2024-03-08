import 'dart:ui';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'dart:convert';


class Values {
  static const String siteUrl = "https://univsportatech.com";
  static const String baseUrl = "https://univsportatech.com";

  static const String appName = "Univ";
  static const String sliderUrl = "$baseUrl/api/sliders";


  //community routes
  static const String fetchPosts = "$baseUrl/api/fetchPosts";
  static const String fetchUsers = "$baseUrl/api/fetchUsers";
  static const String createPost = "$baseUrl/api/createPost";
  static const String deletePost = "$baseUrl/api/deletePost";
  static const String uploadPostMedia = "$baseUrl/api/uploadPostMedia";
  static const String followUser = "$baseUrl/api/followUser";
  static const String unFollowUser = "$baseUrl/api/unFollowUser";
  static const String fetchFollowerData = "$baseUrl/api/followData";
  static const String fetchUserById = "$baseUrl/api/fetchUserById";
  static const String fetchComments = "$baseUrl/api/fetchComments";
  static const String commentPost = "$baseUrl/api/commentPost";
  static const String likePost = "$baseUrl/api/likePost";
  static const String unlikePost = "$baseUrl/api/unlikePost";
  static const String bookmarkPost = "$baseUrl/api/bookmarkPost";
  static const String unBookmarkPost = "$baseUrl/api/unBookmarkPost";
  static const String fetchUserPost = "$baseUrl/api/fetchUserPost";
  static const String fetchPostsById = "$baseUrl/api/fetchPostsById";
  static const String archiveUserFile = "$baseUrl/api/archiveUserFile";
  static const String fetchFollowers = "$baseUrl/api/fetchFollowers";
  static const String fetchFollowings = "$baseUrl/api/fetchFollowing";




  static const Color primaryColor = const Color.fromRGBO(26, 188, 156, 70);

  static const String passwordPolicy = """
1. the password contains at least one uppercase letter (A-Z).
2. the password contains at least one lowercase letter (a-z).
3. the password contains at least one digit (0-9).
4. the password contains at least one special character from the provided set (!@#\$&*~).
5. the password is at least 8 characters long.
  """;

  static bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression for a typical 10-digit Indian phone number
    // Modify the regex pattern according to the phone number format you want to validate
    RegExp regExp = RegExp(r"^[6-9]\d{9}$"); // Example for Indian phone numbers

    return regExp.hasMatch(phoneNumber);
  }

  static bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  static bool isValidPassword(String password) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  static Future<List<dynamic>> fetchData(String url) async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    String urL = '${Values.baseUrl}$url';
    final response = await get(Uri.parse(urL), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200) {
      // If the API call was successful, parse the JSON response

      return json.decode(response.body);
    } else {
      // If the API call was unsuccessful, throw an error
      throw Exception('Failed to load data');
    }
  }

  static getPrefs(String key, int type) async {
    final prefs = await SharedPreferences.getInstance();
    switch (type) {
      case 1:
        prefs.getInt(key);
        break;
      case 2:
        prefs.getString(key);
        break;
    }
  }
  static void cacheFile(String url) {
    final cache = DefaultCacheManager();
    final cachedImage = cache.getSingleFile(url);
    if (cachedImage == null) {
      cache.downloadFile(url);
    }
  }

  static String capitalize(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  static void showMsgDialog(
      String label, String msg, context, Callback callback) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(label),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                onPressed: callback,
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  static void showInternetErrorDialog(String from, var e, var context) {
    if (e
        .toString()
        .contains("ClientException with SocketException: Failed host lookup")) {
      Values.showMsgDialog(from, "Bad or no internet connection", context, () {
        Navigator.pop(context);
      });
    }
  }

  static Future<void> checkAndRequestPermissions() async {
    if (await Permission.camera.request().isGranted &&
        await Permission.storage.request().isGranted) {
      print("permission hai");
    } else {
      print("nahi hai permission");
    }
  }
}
