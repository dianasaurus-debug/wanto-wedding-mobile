import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class VendorNetwork {
  var token;

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'));
  }
  Future<List<Vendor>> getVendor(id) async {
    var full_url = API_URL+'/vendor';
    await _getToken();
    final res = await http.get(Uri.parse(full_url),headers: _setHeaders());


    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'][id];
      if(data!=null){
        return data.map((vendors) => new Vendor.fromJson(vendors)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Vendor>> getThumbnails() async {
    var full_url = API_URL+'/pencarian/rekomendasi';
    await _getToken();
    final res = await http.get(Uri.parse(full_url),headers: _setHeaders());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((vendors) => new Vendor.fromJson(vendors)).toList();
    } else {
      print(jsonDecode(res.body));
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Vendor>> getAllPaketLengkap() async {
    var full_url = API_URL+'/thumbnails/paket-lengkap';
    await _getToken();
    final res = await http.get(Uri.parse(full_url),headers: _setHeaders());

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((vendors) => new Vendor.fromJson(vendors)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<Vendor> getOneVendor(id) async {
    var full_url = API_URL+'/vendor/$id';
    await _getToken();
    final res = await http.get(Uri.parse(full_url),headers: _setHeaders());
    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      var data = json['data'];
      return new Vendor.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<Iterable<dynamic>> getCariVendor(keyword) async {
    var full_url = API_URL+'/pencarian/vendor?cari=${keyword}';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      var data = json['data'];
      return data;
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };
}