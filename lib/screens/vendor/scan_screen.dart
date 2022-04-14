import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../ui_utils.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
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
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: Text(_scanBarcode),
          );
        });
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
