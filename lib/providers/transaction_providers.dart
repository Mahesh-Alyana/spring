import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_service.dart';
import '../models/transaction_details_entity.dart';
import 'package:http/http.dart' as http;

class TransactionListProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late List<TransactionDetailsEntity> _productList = [];

  List<TransactionDetailsEntity> get productList {
    return [..._productList];
  }

  Future<void> getProductList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    var response = await http
        .get(Uri.parse('${ApiConfig.host}/student/transection/'), headers: {
      "Authorization": "JWT $token",
    });
    print(response.body);
    List<TransactionDetailsEntity> productList = [];
    final responseData = json.decode(response.body) as List;

    for (int i = 0; i < responseData.length; i++) {
      TransactionDetailsEntity repo = TransactionDetailsEntity(
        amount: responseData[i]['amount'],
        merchant: responseData[i]['merchant'],
        merchantName: responseData[i]['merchant_name'],
        transectionId: responseData[i]['transaction_id'],
        modified: responseData[i]['modified'],
      );

      productList.add(repo);
    }

    _productList = productList;
    notifyListeners();
  }
}

class TransactionProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late TransactionDetailsEntity _product = TransactionDetailsEntity();

  TransactionDetailsEntity get product {
    return _product;
  }

  Future<void> getProductList(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    var response = await http.get(
      Uri.parse('${ApiConfig.host}/student/transection/$id'),
      headers: {"Authorization": "JWT $token"},
    );

    final responseData = json.decode(response.body);
    print(responseData);

    TransactionDetailsEntity repo = TransactionDetailsEntity(
      amount: responseData['amount'],
      merchant: responseData['merchant'],
      merchantName: responseData['merchant_name'],
      transectionId: responseData['transaction_id'],
      modified: responseData['modified'],
    );

    _product = repo;
    notifyListeners();
  }
}
