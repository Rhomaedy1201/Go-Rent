import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:go_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:go_rent/models/transaction_id_data_model.dart';

class ServiceIdTransaction {
  Future<int?> getIdTransaction() async {
    int result;
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/get_idTransaksi.php"),
      );
      print(response.body);
      if (response.statusCode == 200) {
        result = json.decode(response.body)['result'][0]['id_transaksi'];

        return result;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      log("cekkkkk ${e.toString()}");
    }
  }
}
