import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'api_service.dart';

class ProfileDetails {
  static profile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    final response = await http.get(
      Uri.parse('${ApiConfig.host}/auth/users/me/'),
      headers: {
        "Authorization": "JWT $token",
      },
    );
    print(response.body);
    print(response.statusCode);
    return response.body;
  }

  static userChecking() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString('token').toString();
    final response = await http.get(
        Uri.parse('${ApiConfig.host}/auth/users/me/'),
        headers: {"Authorization": "JWT $token"});
    print(response.body);
    print(response.statusCode);
    return response.statusCode;
  }
}
