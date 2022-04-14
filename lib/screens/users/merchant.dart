import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spring/ui_utils.dart';
import 'package:flutter/src/painting/rounded_rectangle_border.dart';

class TransactionComplete extends StatefulWidget {
  const TransactionComplete({Key? key}) : super(key: key);

  @override
  State<TransactionComplete> createState() => _TransactionCompleteState();
}

class _TransactionCompleteState extends State<TransactionComplete> {
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
      body: Center(
        child: SizedBox(
          width: width * 0.9,
          height: height * 0.9,
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
                  padding: EdgeInsets.only(top: height / 9),
                  child: Center(
                      child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 242, 242, 1),
                            borderRadius: new BorderRadius.circular(16.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(20.00),
                              child: Column(
                                children: [
                                  Center(
                                    child: SvgPicture.asset(
                                      "assets/images/PaymentComplete.svg",
                                      width: width / 3,
                                    ),
                                  ),
                                  Container(
                                    height: 20,
                                  ),
                                  Text(
                                    'Payment Details',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: UiUtils.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.07,
                                    ),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 15,
                                        width: 15,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              new BorderRadius.circular(7.5),
                                        ),
                                      ),
                                      Container(width: 10),
                                      Text(
                                        'Successful',
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: UiUtils.fontFamily,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 0.07,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(height: 10),
                                  Container(
                                    height: 1,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(45, 158, 158, 158)),
                                  ),
                                  Container(height: Spacing),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Name', style: LeftTextStyle),
                                        Text('Aditya', style: TextStyler)
                                      ]),
                                  Container(height: Spacing),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Transaction ID',
                                            style: LeftTextStyle),
                                        Text('#12345678', style: TextStyler)
                                      ]),
                                  Container(height: Spacing),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Amount', style: LeftTextStyle),
                                        Text('60 /-', style: TextStyler)
                                      ]),
                                  Container(height: Spacing),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Time & Date',
                                            style: LeftTextStyle),
                                        Text('10/04/22, 09:46 AM',
                                            style: TextStyler)
                                      ]),
                                ],
                              ))))),
              Container(height: height / 10),
              Container(
                child: Padding(
                    padding: EdgeInsets.only(
                        top: 20.00, bottom: 20, left: 50, right: 50),
                    child: Text('Back',
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: UiUtils.fontFamily,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.07,
                            color: Colors.white))),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(91, 37, 159, 1),
                    borderRadius: BorderRadius.circular(16.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
