import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
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

  updateProfile(File? image, data, apiUrl) async {
    var fullUrl = API_URL + apiUrl;
    await _getToken();


    FormData formData;
    if(image!=null){
      print('gak null');
      String fileName = image.path.split('/').last;
      formData = FormData.fromMap({
        "photo": await MultipartFile.fromFile(image.path, filename:fileName),
        "nama_depan" : data["nama_depan"],
        "nama_belakang" : data["nama_belakang"],
        "alamat" : data["alamat"],
        "_method" : "PUT"
      }
      );
    } else {
      print('null');
      formData = FormData.fromMap({
        "nama_depan" : data["nama_depan"],
        "nama_belakang" : data["nama_belakang"],
        "alamat" : data["alamat"],
        "_method" : "PUT"
      }
      );
    }
    Dio dio = new Dio();
    var headers = {
      'accept': 'application/json',
      'authorization': 'Bearer $token',
      'Content-Type': 'multipart/form-data'
    };
    var response = await dio.post(fullUrl, data: formData, options: Options(method: "POST", headers: headers));
    print(response.data);
    return response.data;
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