import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/screens/users/profile_screen.dart';

import '../../ui_utils.dart';
import '../auth/login_screen.dart';
import 'home_screen.dart';
import 'notification_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          height: height * 0.95,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2, color: UiUtils.medium)),
                  child: FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.white,
                    mini: true,
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 18,
                      color: UiUtils.medium,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Settings",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: UiUtils.dark,
                    fontSize: 24,
                    fontFamily: UiUtils.fontFamily,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.12,
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ),
                    (route) => true,
                  );
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      FloatingActionButton(
                        elevation: 5,
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          "assets/images/username.svg",
                          width: 30,
                          color: Color(0xff130138),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: Color(0xff130138),
                          fontSize: width * 0.05,
                          fontFamily: UiUtils.fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: FractionalOffset.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: UiUtils.dark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationScreen(),
                    ),
                    (route) => true,
                  );
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      FloatingActionButton(
                        elevation: 3,
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          "assets/images/notification_icon.svg",
                          width: 30,
                          color: Color(0xff130138),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Notification",
                        style: TextStyle(
                          color: Color(0xff130138),
                          fontSize: width * 0.05,
                          fontFamily: UiUtils.fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: FractionalOffset.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: UiUtils.dark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      FloatingActionButton(
                        elevation: 5,
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          "assets/images/wallet_icon.svg",
                          width: 30,
                          color: Color(0xff130138),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "wallet",
                        style: TextStyle(
                          color: Color(0xff130138),
                          fontSize: width * 0.05,
                          fontFamily: UiUtils.fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: FractionalOffset.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: UiUtils.dark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => NotificationScreen(),
                  //   ),
                  //   (route) => true,
                  // );
                },
                child: SizedBox(
                  child: Row(
                    children: [
                      FloatingActionButton(
                        elevation: 5,
                        onPressed: () {},
                        backgroundColor: Colors.white,
                        child: SvgPicture.asset(
                          "assets/images/login_icon.svg",
                          width: 30,
                          color: Color(0xff130138),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Login settings",
                        style: TextStyle(
                          color: Color(0xff130138),
                          fontSize: width * 0.05,
                          fontFamily: UiUtils.fontFamily,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.08,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: FractionalOffset.centerRight,
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: UiUtils.dark,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.12,
              ),
              FloatingActionButton(
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.remove('token');
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false);
                },
                backgroundColor: Colors.white,
                child: SvgPicture.asset(
                  "assets/images/logout.svg",
                  color: UiUtils.dark,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Log Out",
                  style: TextStyle(
                    color: UiUtils.medium,
                    fontSize: 22,
                    fontFamily: UiUtils.fontFamily,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.09,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
