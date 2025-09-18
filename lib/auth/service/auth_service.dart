

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noviindus_test2/auth/model/login_model.dart';
import 'package:noviindus_test2/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
 

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.tokenKey);
  }
 
  Future<void> saveToken(String token, ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.tokenKey, token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.tokenKey);
  }


Future<loginModel?> login(String countryCode, String phoneNumber) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${AppConstants.BaseUrl}${AppConstants.verifyOtp}'),
    );

    request.fields['country_code'] = countryCode; 
    request.fields['phone'] = phoneNumber;    

    final streamedResponse = await request.send();
    final responseString = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode == 200 || streamedResponse.statusCode == 202) {
      final Map<String, dynamic> jsonData = json.decode(responseString);
      final loginModel data = loginModel.fromJson(jsonData);

      if (data.token != null) {
        await saveToken(data.token!.access!);
      }

      return data;
    } else {
      print('Error Response: $responseString');
      return null;
    }
  } catch (e) {
    print('Login Exception: $e');
    return null;
  }
}

}