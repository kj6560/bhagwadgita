import 'package:bhagwadgita/utility/values.dart';
import 'package:bhagwadgita/views/pages/myhome.dart';
import 'package:bhagwadgita/views/pages/mylogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Values.primaryColor),
      useMaterial3: true,
    ),
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const MySudoHome()),
      GetPage(
        name: '/login',
        page: () => MyLogin(),
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: '/home',
        page: () => MyHome(),
        transition: Transition.rightToLeft,
      ),
    ],
    home: MySudoHome(),
  ));
}

class MySudoHome extends StatefulWidget {
  const MySudoHome({super.key});

  @override
  State<MySudoHome> createState() => _MySudoHomeState();
}

class _MySudoHomeState extends State<MySudoHome> {
  @override
  void initState() {
    // TODO: implement initState
    isReady();
    super.initState();
  }

  void isReady() async {
    final prefs = await SharedPreferences.getInstance();
    var _token = prefs.getString("token");

    if (_token != null && _token!.isNotEmpty) {
      Get.offAllNamed("/home");
    } else {
      Get.offAllNamed("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: const CircularProgressIndicator(
        color: Colors.blueAccent,
      ),
    );
  }
}
