import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/models/profile_entity.dart';
import 'package:spring/models/profile_model.dart';
import 'package:spring/screens/auth/signup_screen.dart';
import 'package:spring/screens/splashScreen.dart';
import 'package:spring/screens/users/home_screen.dart';
import 'package:spring/ui_utils.dart';

import '../../api/api_service.dart';
import '../../api/profileservices.dart';
import '../../models/login_request_model.dart';
import '../../models/login_response_model.dart';
import 'package:http/http.dart' as http;

import '../vendor/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _emailTC = TextEditingController();
  final TextEditingController _rollNumber = TextEditingController();
  final TextEditingController _passwordTC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
              height: height * 0.92,
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Text(
                      "Welcome back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: UiUtils.dark,
                        fontSize: 24,
                        fontFamily: UiUtils.fontFamily,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.12,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.3,
                    ),
                    Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xfff2f2f2),
                      ),
                      child: TextFormField(
                        controller: _rollNumber,
                        validator: (val) {
                          MultiValidator([
                            RequiredValidator(
                                errorText: "roll number is required to login"),
                           
                          ]);
                        },
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset(
                          //   "assets/images/username.svg",
                          //   height: 3,
                          //   width: 5,
                          // ),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          hintText: "Roll Number",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xfff2f2f2),
                      ),
                      child: TextFormField(
                        controller: _emailTC,
                        validator: (val) {
                          MultiValidator([
                            RequiredValidator(
                                errorText: "Email is required to login"),
                            EmailValidator(
                                errorText:
                                    "Enter a valid mail Id(check whether any extra character added)"),
                          ]);
                        },
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset(
                          //   "assets/images/username.svg",
                          //   height: 3,
                          //   width: 5,
                          // ),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          hintText: "Email ID",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xfff2f2f2),
                      ),
                      child: TextFormField(
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Enter password to login"),
                        ]),
                        controller: _passwordTC,
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset(
                          //   "assets/images/password.svg",
                          // ),
                          prefixIcon: Icon(Icons.key_outlined),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.2,
                    ),
                    Container(
                      width: width * 0.5,
                      height: height * 0.1,
                      decoration: BoxDecoration(
                        color: UiUtils.medium,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: MaterialButton(
                            onPressed: () async {
                              if (formkey.currentState!.validate()) {
                                final String email = _emailTC.text;
                                final String password = _passwordTC.text;
                                showDialog(
                                    context: context,
                                    useRootNavigator: false,
                                    useSafeArea: false,
                                    builder: (context) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color:
                                              Color.fromARGB(255, 0, 157, 255),
                                        ),
                                      );
                                    });
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: email, password: password)
                                    .then((value) async {
                                  final modelRef = FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(_rollNumber.text)
                                      .withConverter<ProfileModel>(
                                        fromFirestore: (snapshot, _) =>
                                            ProfileModel.fromJson(
                                                snapshot.data()!),
                                        toFirestore: (model, _) =>
                                            model.toJson(),
                                      );

                                  // Writes now take a Model as parameter instead of a Map
                                  await modelRef.set(ProfileModel());

                                  // Reads now return a Model instead of a Map
                                  final ProfileModel? model = await modelRef
                                      .get()
                                      .then((s) => s.data());
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setBool(
                                      "admin", model!.merchant!);
                                      sharedPreferences.setString(
                                      "id", _rollNumber.text);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SplashScreen(),
                                      ),
                                      (route) => false);
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: UiUtils.fontFamily,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account yet?",
                              style: TextStyle(
                                fontSize: 13,
                                fontFamily: UiUtils.fontFamily,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignUpScreen()),
                                      (route) => false);
                                },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: UiUtils.fontFamily,
                                    color: Color(0xff81C2FF),
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.07,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
