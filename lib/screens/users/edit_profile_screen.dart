import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/providers/profile_provider.dart';
import 'package:spring/screens/users/home_screen.dart';
import 'package:spring/ui_utils.dart';
import 'package:http/http.dart' as http;

import '../../api/api_service.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfileProvider>(context).getProductList().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  TextEditingController Name = TextEditingController();
  TextEditingController Mail = TextEditingController();
  TextEditingController ID = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var profile = Provider.of<ProfileProvider>(context).profile;
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
          Form(
            key: formkey,
            child: Center(
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
                            border:
                                Border.all(width: 2, color: UiUtils.medium)),
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
                                                  fontFamily:
                                                      UiUtils.fontFamily,
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
                              Text("${Name.text}",
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
                                  controller: Name,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "This field can't be empty")
                                  ]),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                        Icons.person_outline_outlined),
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
                                  controller: ID,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "This field can't be empty")
                                  ]),
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
                              Container(height: 20),
                              Container(
                                width: width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: const Color(0xfff2f2f2),
                                ),
                                child: TextFormField(
                                  controller: Mail,
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "This field can't be empty")
                                  ]),
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.password),
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Container(height: height / 15),
                              FloatingActionButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    var token = sharedPreferences
                                        .getString("token")
                                        .toString();
                                    final Map<String, dynamic> data =
                                        new Map<String, dynamic>();
                                    data["user_id"] = "${ID.text}";
                                    data["first_name"] = "${Name.text}";
                                    data["email"] = "${profile.email}";
                                    data["last_name"] = "${profile.lastName}";
                                    data["password"] = "${Mail.text}";
                                    print(data);
                                    var request = await http.put(
                                      Uri.parse(
                                          "${ApiConfig.host}/auth/users/me/"),
                                      body: data,
                                      headers: {
                                        "Content-Type":
                                            "application/x-www-form-urlencoded",
                                        "Accept": "application/json",
                                        "Authorization": "JWT $token",
                                      },
                                    );
                                    print(request.statusCode);
                                    print(request.body);
                                  }
                                  Navigator.pop(context);
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
          )
        ],
      ),
    );
  }
}
