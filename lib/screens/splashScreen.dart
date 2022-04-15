import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

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
    required this.task,
    required this.uid,
    required this.token,
  }) : super(key: key);
  String task;
  String uid;
  String token;

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    if (widget.task != '') {
      print("ok");
    }
    // verify(deepLinkURL);
    getToken().whenComplete(() async {
      var profile = json.decode(await ProfileDetails.profile());
      ProfileEntity profileEntity =
          ProfileEntity(typeOfAccount: profile['type_of_account']);
      Timer(
        const Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => finalToken == null
                    ? LoginScreen()
                    : profileEntity.typeOfAccount == "STUDENT"
                        ? HomeScreen()
                        : MerchantHomeScreen()),
            (route) => false),
      );
    });

    super.initState();
  }

  Future getToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedToken = sharedPreferences.getString("token");
    finalToken = obtainedToken;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
