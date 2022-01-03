import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dream_wedding_app/utils/constants.dart';
class AuthNetwork{

  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  authData(data, apiUrl) async {
    var fullUrl = API_URL + apiUrl;
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
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

  updateProfile(String file, data, apiUrl) async {
    var fullUrl = API_URL + apiUrl;
    await _getToken();
    Map<String,String> headers={
      "Authorization":"Bearer $token",
      "Content-type": "multipart/form-data",
      "Accept" : "application/json",
    };
    var request = http.MultipartRequest(
      'POST', Uri.parse(fullUrl),

    );
    request.files.add(
        await http.MultipartFile.fromPath('photo', file)
    );
    request.headers.addAll(headers);
    request.fields.addAll(data);
    var res = await request.send();
    var responseString = await res.stream.bytesToString();
    print(responseString);
    return responseString;
  }



  getData(apiUrl) async {
    var fullUrl = API_URL + apiUrl;
    await _getToken();
    return await http.get(
        Uri.parse(fullUrl),
        headers: _setHeaders()
    );
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}