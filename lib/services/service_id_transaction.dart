import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:go_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:go_rent/models/transaction_id_data_model.dart';

class ServiceIdTransaction {
  Future<List<TransactionIdDataModel>> getIdTransaction() async {
    List<TransactionIdDataModel> result = [];
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/get_IdTransaksi.php"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['result'];

        data.forEach((element) {
          result.add(TransactionIdDataModel.fromJson(element));
        });

        return result;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
