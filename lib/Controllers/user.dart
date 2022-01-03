import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/Models/user.dart';
import 'package:dream_wedding_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserNetwork {
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  Future<User> getProfile() async {
    var full_url = API_URL+'/profile';
    await _getToken();
    final res = await http.get( Uri.parse(full_url),
        headers: _setHeaders());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      var data = json['data'];
      return new User.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  postData(data, apiUrl) async {
    var fullUrl = API_URL + apiUrl;
    await _getToken();
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}