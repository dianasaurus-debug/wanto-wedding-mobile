import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/Models/vendor.dart';
import 'package:dream_wedding_app/utils/constants.dart';
class VendorNetwork {
  Future<List<Vendor>> getVendor(id) async {
    var full_url = API_URL+'/vendor';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'][id];
      return data.map((vendors) => new Vendor.fromJson(vendors)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Vendor>> getThumbnails() async {
    var full_url = API_URL+'/thumbnails/vendor';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((vendors) => new Vendor.fromJson(vendors)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Vendor>> getAllPaketLengkap() async {
    var full_url = API_URL+'/thumbnails/paket-lengkap';
    final res = await http.get(Uri.parse(full_url));

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
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      var data = json['data'];
      return new Vendor.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}