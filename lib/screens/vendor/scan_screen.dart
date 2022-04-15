import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spring/screens/vendor/payment_success_screen.dart';
import '../../api/api_service.dart';
import '../../ui_utils.dart';
import 'package:http/http.dart' as http;

class ScanScreen extends StatefulWidget {
  ScanScreen({Key? key, required this.amount}) : super(key: key);
  String amount;
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
      'key': 'rzp_live_a4PzMufSL9ChFW',
      'amount': int.parse(amount) / 100,
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
    var token = sharedPreferences.getString("token");
    var request = await http.post(
        Uri.parse("${ApiConfig.host}/main/pay/success"),
        body: postdat,
        headers: {"Authorization": "JWT $token"});
    if (request.statusCode == 200) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => TransactionComplete()),
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

  String _scanBarcode = 'Unknown';

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token").toString();
    print(token);

    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = _scanBarcode;
    data["prize"] = widget.amount;
    var request = await http.post(
      Uri.parse("${ApiConfig.host}/student/transfer_money/"),
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
            builder: (context) => TransactionComplete(),
          ),
          (route) => false);
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(json.decode(request.body)['message']),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: height * 0.9,
          width: width * 0.9,
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
                  "Scan QR code",
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
                height: height * 0.1,
              ),
              Image.asset("assets/images/barcode.png"),
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
                      onPressed: () => scanBarcodeNormal(),
                      child: Center(
                        child: Text(
                          "Scan",
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
        ),
      ),
    );
  }
}
