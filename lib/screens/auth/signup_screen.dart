import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:open_mail_app/open_mail_app.dart';
import 'package:spring/screens/auth/login_screen.dart';
import '../../api/auth_api.dart';
import '../../ui_utils.dart';
import '../splashScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController _nameTC = TextEditingController();
  TextEditingController _rollNumberTC = TextEditingController();
  TextEditingController _emailTC = TextEditingController();
  TextEditingController _passwordTC = TextEditingController();
  TextEditingController _repasswordTC = TextEditingController();

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
                      "Welcome",
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
                      height: height * 0.1,
                    ),
                    Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xfff2f2f2),
                      ),
                      child: TextFormField(
                        controller: _nameTC,
                        validator: MultiValidator([
                          RequiredValidator(errorText: "email can't be empty"),
                        ]),
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset(
                          //   "assets/images/username.svg",
                          //   height: 3,
                          //   width: 5,
                          // ),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                          hintText: "Username",
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
                        validator: MultiValidator([
                          EmailValidator(errorText: 'invalid email'),
                          RequiredValidator(errorText: "email can't be empty"),
                          MinLengthValidator(13,
                              errorText: 'email can\'t be empty')
                        ]),
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset(
                          //   "assets/images/username.svg",
                          //   height: 3,
                          //   width: 5,
                          // ),
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: "email",
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
                        controller: _passwordTC,
                        obscureText: true,
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Password can't be empty"),
                          MinLengthValidator(8,
                              errorText: "Password should be 8 characters")
                        ]),
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
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xfff2f2f2),
                      ),
                      child: TextFormField(
                        controller: _repasswordTC,
                        validator: (val) {
                          if (val != _passwordTC.text) {
                            return 'It should match with above password';
                          }
                          MultiValidator([
                            RequiredValidator(
                                errorText: "Password can't be empty"),
                            MinLengthValidator(8,
                                errorText: "Password should be 8 characters"),
                          ]);
                        },
                        decoration: InputDecoration(
                          // prefixIcon: SvgPicture.asset(
                          //   "assets/images/password.svg",
                          // ),
                          prefixIcon: Icon(Icons.key_outlined),
                          suffixIcon: Icon(Icons.remove_red_eye_outlined),
                          hintText: "Confirm password",
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
                                showDialog(
                                    barrierDismissible: false,
                                    useRootNavigator: false,
                                    context: context,
                                    builder: (context) {
                                      return Center(
                                        child: CircularProgressIndicator(
                                          color: Color(0xFFFF0000),
                                        ),
                                      );
                                    });
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: _emailTC.text,
                                        password: _passwordTC.text)
                                    .then((value) {
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      .set({
                                    "name": _nameTC.text,
                                    "id": _rollNumberTC.text,
                                    "email": _emailTC.text,
                                    "amount": 0,
                                    "merchant": false,
                                    "active": true
                                  });
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SplashScreen()),
                                      (route) => false);
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Center(
                              child: Text(
                                "Register",
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
                              "Already have an account?",
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
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: Text(
                                  "Login",
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
