import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../controllers/logincontroller.dart';
import '../../services/remote_services.dart';
import '../../utility/values.dart';
import '../contents/login.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _LoginState();
}

class _LoginState extends State<MyLogin> {


  void signup() {
    //Navigator.of(context).pushNamed('register');
  }

  @override
  void initState() {
    super.initState();
    //RemoteServices.showSnackBar(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe6e6e6),
      body: Login(),
    );
  }
}
