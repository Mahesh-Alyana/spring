import 'dart:async';

import 'package:flutter/material.dart';

import '../ui_utils.dart';

class WalletTile extends StatefulWidget {
  const WalletTile({Key? key}) : super(key: key);

  @override
  State<WalletTile> createState() => _WalletTileState();
}

class _WalletTileState extends State<WalletTile> {
  double size1 = 50;
  double size2 = 10;
  @override
  void initState() {
    Timer(Duration(milliseconds: 10), () {
      setState(() {
        size1 = 140;
        size2 = 54;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      height: height * 0.2,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black38,
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(50),
        color: UiUtils.medium,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(children: [
          Positioned(
              top: -15,
              left: 10,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 2000),
                height: size2,
                width: size2,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: UiUtils.light),
              )),
          Positioned(
            bottom: -55,
            right: -45,
            child: AnimatedContainer(
              height: size1,
              width: size1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 3,
                  color: const Color(0xff9038FF),
                ),
              ),
              duration: const Duration(milliseconds: 2000),
            ),
          ),
          // Positioned(
          //   child: Image.asset(
          //     "assets/images/curve1.png",
          //     fit: BoxFit.fill,
          //   ),
          // ),

          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Balance",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: UiUtils.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "3000",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: UiUtils.fontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
