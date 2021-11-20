import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/Models/katalog.dart';
import 'package:dream_wedding_app/utils/constants.dart';
class KatalogNetwork {
  Future<List<Katalog>> getKatalog() async {
    var full_url = API_URL+'/katalog';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((katalog) => new Katalog.fromJson(katalog)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}