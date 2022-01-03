import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/Models/booking.dart';
import 'package:dream_wedding_app/utils/constants.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
class BookingNetwork {
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }

  Future<List<Booking>> getAllBookings() async {
    var full_url = API_URL+'/booking/list';
    await _getToken();
    final res = await http.get( Uri.parse(full_url),
        headers: _setHeaders());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((bookings) => new Booking.fromJson(bookings)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<Booking> getBookingDetail(id) async {
    var full_url = API_URL+'/booking/detail/${id}';
    await _getToken();
    final res = await http.get( Uri.parse(full_url),
        headers: _setHeaders());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      var data = json['data'];
      return new Booking.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  cancelBooking(id) async {
    var full_url = API_URL+'/booking/cancel/${id}';
    await _getToken();
   return await http.put( Uri.parse(full_url),
        headers: _setHeaders());
  }
  addReview(data) async {
    var fullUrl = API_URL + '/review/add';
    await _getToken();
    return await http.post(
        Uri.parse(fullUrl),
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }

  uploadBuktiPembayaran(File image, apiUrl) async {
    var fullUrl = API_URL + apiUrl;
    await _getToken();

    String fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "bukti_pembayaran": await MultipartFile.fromFile(image.path, filename:fileName),
      "_method" : "PUT"
    }
    );
    Dio dio = new Dio();
    var headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
      'authorization': 'Bearer $token',
    };
    var response = await dio.post(fullUrl, data: formData, options: Options(method: "POST", headers: headers));
    return response.data;
  }

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}