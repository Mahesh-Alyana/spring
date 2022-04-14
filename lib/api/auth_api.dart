import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sign_up_model.dart';
import 'api_service.dart';

class AuthApiConfig {
  static Future<String?> signUp(String email, String password,
      String rePassword, String firstName, String lastName) async {
    String url = "${ApiConfig.host}/auth/users/";
    SignUpRequestModel requestModel = SignUpRequestModel(
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
      rePassword: rePassword,
    );
    final response = await http.post(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestModel.toJson()));
    print(
        'jsonEncode(requestModel.toJson()): ${jsonEncode(requestModel.toJson())}');

    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      print("Successfully completed");
      print(response.body);
      return response.body;
    } else if (response.statusCode == 400) {
      print(response.body);
    } else {
      print(response.body);

      throw Exception('Failed to load data!');
    }
  }

  static Future<String?> resetPassword(String email) async {
    String url = "${ApiConfig.host}/auth/users/reset_password/";

    final response = await http.post(Uri.parse(url), body: {'email': email});
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Successfully completed");
      print(response.body);
      return response.body;
    } else if (response.statusCode == 400) {
      return response.statusCode as String;
    } else {
      print(response.body);

      throw Exception('Failed to load data!');
    }
  }

  static Future<String?> resetPasswordfinal(
      String uid, String token, String newPassword, String rePassword) async {
    String url = "${ApiConfig.host}/auth/users/reset_password_confirm/";

    final response = await http.post(Uri.parse(url), body: {
      'uid': uid,
      'token': token,
      'new_password': newPassword,
      're_new_password': rePassword,
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Successfully completed");
      print(response.body);
      return response.body;
    } else if (response.statusCode == 400) {
      print(response.body);
      // return response.statusCode;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  static Future<String?> activation(String uid, String token) async {
    String url = "${ApiConfig.host}/auth/users/activation/";
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = uid;
    data['token'] = token;
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Successfully completed");
      print(response.body);
      return response.body;
    } else if (response.statusCode == 400) {
      return response.statusCode as String;
    } else {
      print(response.body);

      throw Exception('Failed to load data!');
    }
  }

  static Future<String?> resendActivation(String email) async {
    String url = "${ApiConfig.host}/auth/users/resend_activation/";
    final response = await http.post(Uri.parse(url), body: {
      'email': email,
    });
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 204) {
      print("Successfully completed");
      print(response.body);
      return response.body;
    } else if (response.statusCode == 400) {
      print(response.body);
    } else {
      print(response.body);
      throw Exception('Failed to load data!');
    }
  }
}
