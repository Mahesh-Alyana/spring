import 'dart:convert';

import 'package:flutter/material.dart';

import '../api/profileservices.dart';
import '../models/profile_entity.dart';

class ProfileProvider extends ChangeNotifier {
  // ignore: deprecated_member_use
  late ProfileEntity _profile = ProfileEntity();

  ProfileEntity get profile {
    return _profile;
  }

  Future<void> getProductList() async {
    var response = await ProfileDetails.profile();

    final responseData = json.decode(response);

    ProfileEntity repo = ProfileEntity(
      userId: responseData['first_name'],
      firstName: responseData['first_name'],
      lastName: responseData['last_name'],
      email: responseData['email'],
      amount: responseData['amount'],
      card: responseData['card'],
      typeOfAccount: responseData['type_of_account'],
    );

    _profile = repo;
    notifyListeners();
  }
}
