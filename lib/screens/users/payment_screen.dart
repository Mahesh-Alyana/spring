import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/api/api_service.dart';
import 'package:spring/providers/profile_provider.dart';
import 'package:spring/screens/vendor/payment_success_screen.dart';
import 'package:spring/ui_utils.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/payment_model.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController userId = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController amount = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: SizedBox(
                width: width * 0.9,
                height: height,
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 2, color: UiUtils.medium),
                          ),
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
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Text(
                        "Pay to others",
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
                        height: height * 0.2,
                      ),
                      Container(
                        width: width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xfff2f2f2),
                        ),
                        child: TextFormField(
                          controller: userName,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field can't be empty")
                          ]),
                          decoration: InputDecoration(
                            // prefixIcon: SvgPicture.asset(
                            //   "assets/images/username.svg",
                            //   height: 3,
                            //   width: 5,
                            // ),
                            prefixIcon: Icon(Icons.person_outline_rounded),
                            hintText: "Name",
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
                          controller: userId,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field can't be eampty")
                          ]),
                          decoration: InputDecoration(
                            // prefixIcon: SvgPicture.asset(
                            //   "assets/images/username.svg",
                            //   height: 3,
                            //   width: 5,
                            // ),
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "User ID",
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
                          controller: amount,
                          keyboardType: TextInputType.number,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "This field can't be eampty")
                          ]),
                          decoration: InputDecoration(
                            // prefixIcon: SvgPicture.asset(
                            //   "assets/images/password.svg",
                            // ),
                            prefixIcon: Icon(Icons.currency_rupee_rounded),
                            hintText: "Amount",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.1,
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
                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  var token = sharedPreferences
                                      .getString("token")
                                      .toString();
                                  print(token);

                                  final Map<String, dynamic> data =
                                      new Map<String, dynamic>();
                                  data["id"] = "${userId.text}";
                                  data["prize"] = "${amount.text}";
                                  var request = await http.post(
                                    Uri.parse(
                                        "${ApiConfig.host}/student/transfer_money/"),
                                    body: data,
                                    headers: {
                                      // "Content-Type":
                                      //     "application/x-www-form-urlencoded",
                                      "Accept": "application/json",
                                      "Authorization": "JWT $token",
                                    },
                                  );
                                  print(request.statusCode);
                                  print(request.body);
                                  if (request.statusCode == 200) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TransactionComplete()),
                                        (route) => false);
                                  }
                                }
                              },
                              child: Center(
                                child: Text(
                                  "Pay",
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
                    ],
                  ),
                )),
          )
        ],
      ),
    );
  }
}

class PaymentStart extends StatefulWidget {
  const PaymentStart({Key? key}) : super(key: key);

  @override
  State<PaymentStart> createState() => _PaymentStartState();
}

class _PaymentStartState extends State<PaymentStart> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfileProvider>(context).getProductList().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
  }

  int amount = 0;
  late Razorpay _razorpay = Razorpay();
  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  void openCheckout(
      String orderID, String amount, String name, String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var options = {
      'key': 'rzp_test_7JPoEZqhx1pXEh',
      'amount': int.parse(amount),
      'name': name,
      'description': 'Process order',
      'retry': {'enabled': true, 'max_count': 2},
      'send_sms_hash': true,
      'prefill': {'contact': '', 'email': email},
      'external': {
        'wallets': ['paytm']
      },
      "order_id": orderID,
      "theme.color": "#5B259F"
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: ${e}');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
        msg: "Successfully completed", toastLength: Toast.LENGTH_SHORT);
    var postdat = {
      "razorpay_payment_id": response.paymentId,
      "razorpay_order_id": response.orderId,
      "razorpay_signature": response.signature
    };
    print(response.paymentId);
    print(response.orderId);
    print(response.signature);
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token").toString();
    var request = await http.post(
        Uri.parse("${ApiConfig.host}/student/pay/success/"),
        body: postdat,
        headers: {"Authorization": "JWT $token"});
    print(request.statusCode);
    if (request.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const TransactionComplete()),
        (route) => false,
      );
      setState(() {
        loading = false;
      });
    }
  }

  bool loading = false;

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "Sorry an error occured,please try again",
        toastLength: Toast.LENGTH_LONG);
    print("ERROR: " + response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Navigator.pop(context);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ProfileProvider>(context).profile;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          Center(
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
                          onPressed: () {},
                          backgroundColor: Colors.white,
                          mini: true,
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 18,
                            color: UiUtils.medium,
                          )),
                    ),
                  ),
                  Text(
                    "$amount",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: UiUtils.dark,
                      fontSize: 36,
                      fontFamily: UiUtils.fontFamily,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.18,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Container(
                    width: width * 0.8,
                    height: 66,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 196, 196, 196),
                    ),
                    child: Center(
                      child: TextFormField(
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 20, top: 30),
                          hintStyle: TextStyle(
                            color: Color(0xff363853),
                            fontSize: 20,
                            fontFamily: UiUtils.fontFamily,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.08,
                          ),
                          hintText: "Reason",
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  NumericKeyboard(
                    onKeyboardTap: (val) {
                      setState(() {
                        amount = int.parse("$amount" + val);
                      });
                    },
                    textColor: UiUtils.dark,
                    rightButtonFn: () {
                      setState(() {
                        amount = "$amount".substring(0, -1) as int;
                      });
                    },
                    rightIcon: Icon(
                      Icons.cancel_outlined,
                      size: 25,
                      color: UiUtils.dark,
                    ),
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.6,
                    height: height * 0.08,
                    decoration: BoxDecoration(
                      color: UiUtils.medium,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: MaterialButton(
                          onPressed: () async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            var token =
                                sharedPreferences.getString("token").toString();
                            print(token);
                            final Map<String, dynamic> data =
                                new Map<String, dynamic>();
                            data["amount"] = "$amount";
                            var request = await http.post(
                              Uri.parse("${ApiConfig.host}/student/pay/"),
                              body: data,
                              headers: {
                                "Accept": "application/json",
                                "Authorization": "JWT $token",
                              },
                            );
                            print(request.statusCode);
                            print(request.body);
                            if (request.statusCode == 200) {
                              var responseData = json.decode(request.body);
                              PaymentModel data = PaymentModel(
                                  payment: responseData["payment"]);
                              print(data.payment!.split("'"));
                              var key = data.payment!.split("'")[3];
                              print(key.split(","));
                              var orderId = key.split(",")[0];
                              print(orderId);
                              openCheckout(orderId, "$amount",
                                  "${profile.firstName}", "${profile.email}");
                            }
                          },
                          child: Center(
                            child: Text(
                              "Add money",
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
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
