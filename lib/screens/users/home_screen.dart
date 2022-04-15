import 'dart:async';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/providers/profile_provider.dart';
import 'package:spring/screens/users/notification_screen.dart';
import 'package:spring/screens/users/payment_details.dart';
import 'package:spring/screens/users/payment_screen.dart';
import 'package:spring/screens/users/profile_screen.dart';
import 'package:spring/screens/users/settings_screen.dart';
import 'package:spring/screens/users/transaction_history.dart';
import 'package:http/http.dart' as http;
import 'package:spring/ui_utils.dart';
import 'package:spring/widgets/transaction_tile.dart';
import 'package:spring/widgets/wallettile.dart';

import '../../api/api_service.dart';
import '../../providers/transaction_providers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int value = 0;
  Color color = UiUtils.light;
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      setState(() {
        color = UiUtils.dark;
      });
    });
    // TODO: implement initState
    super.initState();
  }

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
          if (Provider.of<ProfileProvider>(context, listen: false)
                  .profile
                  .card ==
              true) {
            value = 1;
          } else {
            value = 0;
          }
        });
      });
      Provider.of<TransactionListProvider>(context)
          .getProductList()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ProfileProvider>(context).profile;
    var transactions =
        Provider.of<TransactionListProvider>(context).productList;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: UiUtils.medium),
            )
          : Center(
              child: SizedBox(
                width: width * 0.95,
                height: height * 0.95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.81,
                      child: ListView.builder(
                          itemCount: transactions.length > 3
                              ? 4
                              : transactions.length + 1,
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Column(
                                children: [
                                  SizedBox(
                                    width: width * 0.85,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${profile.firstName}",
                                              style: TextStyle(
                                                color: UiUtils.dark,
                                                fontSize: 24,
                                                fontFamily: UiUtils.fontFamily,
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 0.12,
                                              ),
                                            ),
                                            StreamBuilder(
                                                builder: ((context, snapshot) {
                                              return Text(
                                                profile.card == true
                                                    ? "Active"
                                                    : "Inactive",
                                                style: TextStyle(
                                                  color: UiUtils.lightText,
                                                  fontSize: 16,
                                                  fontFamily:
                                                      UiUtils.fontFamily,
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.08,
                                                ),
                                              );
                                            }))
                                          ],
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Profile()),
                                                (route) => true);
                                          },
                                          child: CircleAvatar(
                                              child: Image.asset(
                                                  "assets/images/profile.png")),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Wallet - ",
                                        style: TextStyle(
                                          color: UiUtils.dark,
                                          fontSize: 25,
                                          fontFamily: UiUtils.fontFamily,
                                          fontWeight: FontWeight.w800,
                                          letterSpacing: 0.12,
                                        ),
                                      ),
                                      Container(
                                        width: 54,
                                        child:
                                            AnimatedToggleSwitch<int>.rolling(
                                          current: value,
                                          values: const [0, 1],
                                          onChanged: (i) async {
                                            setState(() => value = i);
                                            SharedPreferences
                                                sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            var token = sharedPreferences
                                                .getString("token");
                                            var request = await http.get(
                                                Uri.parse(
                                                    "${ApiConfig.host}/student/control_card/"),
                                                headers: {
                                                  "Authorization": "JWT $token"
                                                });
                                            Provider.of<ProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .getProductList();
                                          },
                                          borderWidth: 3,
                                          indicatorColor: Colors.white,
                                          innerColor: value == 0
                                              ? Colors.red
                                              : Colors.green,
                                          height: 30,
                                          dif: 5.0,
                                          borderColor: Colors.transparent,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  WalletTile(
                                    amount: "${profile.amount}",
                                  ),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          FloatingActionButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PaymentScreen(),
                                                  ),
                                                  (route) => true);
                                            },
                                            backgroundColor: Colors.white,
                                            child: SvgPicture.asset(
                                              "assets/images/payment.svg",
                                              width: 30,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Payment",
                                              style: TextStyle(
                                                color: UiUtils.text,
                                                fontSize: 13,
                                                fontFamily: UiUtils.fontFamily,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.07,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          FloatingActionButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const PaymentStart(),
                                                  ),
                                                  (route) => true);
                                            },
                                            backgroundColor: Colors.white,
                                            // child: SvgPicture.asset("assets/images/payment.svg"),
                                            child: Center(
                                              child: Icon(
                                                Icons
                                                    .add_circle_outline_rounded,
                                                color: UiUtils.dark,
                                                size: 30,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(22)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Top up",
                                              style: TextStyle(
                                                color: UiUtils.text,
                                                fontSize: 13,
                                                fontFamily: UiUtils.fontFamily,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.07,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: width * 0.87,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Last Transaction",
                                          style: TextStyle(
                                            color: Color(0xff130138),
                                            fontSize: 18,
                                            fontFamily: UiUtils.fontFamily,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: 0.09,
                                          ),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TransactionHistory()),
                                                  (route) => true);
                                            },
                                            child: Text(
                                              "View All",
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                color: Color(0xff8338ff),
                                                fontSize: 13,
                                                fontFamily: UiUtils.fontFamily,
                                                fontWeight: FontWeight.w500,
                                                letterSpacing: 0.07,
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionDetails(
                                            id: '${transactions[index - 1].transectionId}',
                                          ),
                                        ),
                                        (route) => true);
                                  },
                                  child: TransactionTile(
                                    id: "${transactions[index - 1].transectionId}",
                                  ));
                            }
                          }),
                    ),
                    // TransactionTile(),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 2000),
                          height: height * 0.12,
                          width: width * 0.87,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x19272246),
                                blurRadius: 12,
                                offset: Offset(0, 8),
                              ),
                            ],
                            color: color,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset("assets/images/payment_on.svg"),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TransactionHistory(),
                                      ),
                                      (route) => true,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/transaction_off.svg")),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationScreen(),
                                    ),
                                    (route) => true,
                                  );
                                },
                                child: SvgPicture.asset(
                                  "assets/images/notification_off.svg",
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingsScreen(),
                                      ),
                                      (route) => true,
                                    );
                                  },
                                  child: SvgPicture.asset(
                                      "assets/images/setting_off.svg"))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
