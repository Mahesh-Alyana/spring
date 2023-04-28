import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/api/auth_api.dart';
import 'package:spring/screens/users/home_screen.dart';
import 'package:spring/screens/vendor/home_screen.dart';

import '../api/profileservices.dart';
import '../models/profile_entity.dart';
import 'auth/login_screen.dart';

String? finalToken;
// ignore: non_constant_identifier_names

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  SplashScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getToken().whenComplete(() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      bool? merchant = sharedPreferences.getBool("admin");
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => merchant == null
                    ? LoginScreen()
                    : merchant
                        ? HomeScreen()
                        : MerchantHomeScreen()),
            (route) => false),
      );
    });

    super.initState();
  }

  Future getToken() async {
    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    // var obtainedToken = sharedPreferences.getString("token");
    // finalToken = obtainedToken;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SvgPicture.asset(
        "assets/images/logo.svg",
        width: 400,
        fit: BoxFit.fitWidth,
      )),
    );
  }
}
