import 'package:dream_wedding_app/Models/bank_account.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:dream_wedding_app/Models/katalog.dart';
import 'package:dream_wedding_app/utils/constants.dart';
class BankAccountNetwork {
  Future<List<BankAccount>> getBankAccount() async {
    var full_url = API_URL+'/bank';
    final res = await http.get(Uri.parse(full_url));

    if (res.statusCode == 200) {
      var json = jsonDecode(res.body);
      List data = json['data'];
      return data.map((bank) => new BankAccount.fromJson(bank)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }
}