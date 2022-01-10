import 'package:dream_wedding_app/Models/kategori.dart';
import 'package:dream_wedding_app/Models/tema.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/utils/constants.dart';
class CategoryNetwork {
  Future<List<Tema>> getAllTema() async {
    var full_url = API_URL+'/categories/tema';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      if(data!=null){
        return data.map((tema) => new Tema.fromJson(tema)).toList();
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }
  Future<List<Kategori>> getAllCategories() async {
    var full_url = API_URL+'/thumbnails/vendor';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((kategori) => new Kategori.fromJson(kategori)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}