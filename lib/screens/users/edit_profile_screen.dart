import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spring/screens/users/home_screen.dart';
import 'package:spring/ui_utils.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    const double fontSize = 17;
    const double Spacing = 17;
    var TextStyler = TextStyle(
      fontSize: 17,
      fontFamily: UiUtils.fontFamily,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.07,
    );
    var LeftTextStyle = TextStyle(
      fontSize: fontSize,
      color: Colors.grey,
      fontFamily: UiUtils.fontFamily,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.07,
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
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
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30),
                    child: Container(
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                    child: Container(
                                        child: Text("Edit profile",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontFamily: UiUtils.fontFamily,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.07,
                                                color: Color.fromRGBO(
                                                    19, 1, 56, 1))))),
                              ],
                            ),
                            Container(height: height * 0.02),
                            Image.asset("assets/images/profile.png",
                                width: width / 5,
                                height: width / 5,
                                fit: BoxFit.fitWidth),
                            Container(height: 20),
                            Text("Aditya",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: UiUtils.fontFamily,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(19, 1, 56, 1))),
                            Container(height: 10),
                            Container(
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xfff2f2f2),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon:
                                      const Icon(Icons.person_outline_outlined),
                                  hintText: "Name",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 20),
                            Container(
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xfff2f2f2),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.mail),
                                  hintText: "Email",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Container(height: 20),
                            Container(
                              width: width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xfff2f2f2),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  hintText: "ID",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Container(height: height / 15),
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (route) => false);
                              },
                              backgroundColor: Colors.white,
                              child: SvgPicture.asset(
                                "assets/images/update.svg",
                                width: width * 0.07,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                "Update",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: UiUtils.fontFamily,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.07,
                                  color: Color.fromRGBO(91, 37, 159, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
