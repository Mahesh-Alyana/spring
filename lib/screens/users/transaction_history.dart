import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spring/screens/users/payment_details.dart';
import 'package:spring/ui_utils.dart';
import 'package:spring/widgets/transaction_tile.dart';

import '../../providers/transaction_providers.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({Key? key}) : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_init) {
      setState(() {
        _isLoading = true;
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
    var transactions =
        Provider.of<TransactionListProvider>(context).productList;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Transactions",
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
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Icon(
                      //     Icons.filter_alt_outlined,
                      //     color: UiUtils.dark,
                      //   ),
                      // ),
                      // Expanded(
                      //   child: Align(
                      //     alignment: FractionalOffset.centerRight,
                      //     child: Icon(
                      //       Icons.filter_alt_outlined,
                      //       color: UiUtils.dark,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.7,
                child: ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TransactionDetails(
                                    id: "${transactions[index].transectionId}",
                                  ),
                                ),
                                (route) => true);
                          },
                          child: TransactionTile(
                            id: '',
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
