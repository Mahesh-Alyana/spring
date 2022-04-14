import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spring/screens/users/notification_screen.dart';
import 'package:spring/screens/users/transaction_history.dart';
import 'package:spring/ui_utils.dart';
import 'package:spring/widgets/transaction_tile.dart';
import 'package:spring/widgets/wallettile.dart';

class MerchantHomeScreen extends StatefulWidget {
  const MerchantHomeScreen({Key? key}) : super(key: key);

  @override
  State<MerchantHomeScreen> createState() => _MerchantHomeScreenState();
}

class _MerchantHomeScreenState extends State<MerchantHomeScreen> {
  int value = 1;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: width * 0.95,
          height: height * 0.95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.81,
                child: ListView.builder(itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      children: [
                        SizedBox(
                          width: width * 0.85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Wallet",
                                    style: TextStyle(
                                      color: UiUtils.dark,
                                      fontSize: 24,
                                      fontFamily: UiUtils.fontFamily,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 0.12,
                                    ),
                                  ),
                                  Text(
                                    "Active",
                                    style: TextStyle(
                                      color: UiUtils.lightText,
                                      fontSize: 16,
                                      fontFamily: UiUtils.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.08,
                                    ),
                                  )
                                ],
                              ),
                              CircleAvatar(
                                  child:
                                      Image.asset("assets/images/profile.png")),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "Wallet - ",
                        //       style: TextStyle(
                        //         color: UiUtils.dark,
                        //         fontSize: 25,
                        //         fontFamily: UiUtils.fontFamily,
                        //         fontWeight: FontWeight.w800,
                        //         letterSpacing: 0.12,
                        //       ),
                        //     ),
                        //     Container(
                        //       width: 54,
                        //       child: AnimatedToggleSwitch<int>.rolling(
                        //         current: value,
                        //         values: const [0, 1],
                        //         onChanged: (i) => setState(() => value = i),
                        //         borderWidth: 3,
                        //         indicatorColor: Colors.white,
                        //         innerColor:
                        //             value == 0 ? Colors.red : Colors.green,
                        //         height: 30,
                        //         dif: 5.0,
                        //         borderColor: Colors.transparent,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        WalletTile(),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                FloatingActionButton(
                                  onPressed: () {},
                                  backgroundColor: Colors.white,
                                  child: SvgPicture.asset(
                                    "assets/images/scan.svg",
                                    color: UiUtils.dark,
                                  ),
                                  // child: Center(
                                  //   child: Icon(
                                  //     Icons.add_circle_outline_rounded,
                                  //     color: UiUtils.dark,
                                  //     size: 30,
                                  //   ),
                                  // ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(22)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Scan",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  }
                  return TransactionTile();
                }),
              ),
              // TransactionTile(),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
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
                      color: UiUtils.dark,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset("assets/images/payment_on.svg"),
                        SvgPicture.asset("assets/images/transaction_off.svg"),
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
                          child: SvgPicture.asset(
                            "assets/images/scan.svg",
                          ),
                        ),
                        SvgPicture.asset("assets/images/setting_off.svg")
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
