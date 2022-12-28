import 'dart:convert';
import 'dart:io';

import 'package:go_rent/models/data_transaction_model.dart';
import 'package:go_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;

class DataTransactionService {
  Future<List<DataTransactionModel>> getDataTransactionUseIdUser(
      String idUser) async {
    var response = await http.get(
      Uri.parse("$baseUrl/get_transaksi.php?id_user=$idUser"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['result'];
      List<DataTransactionModel> result = [];

      for (var item in data) {
        result.add(DataTransactionModel.fromJson(item));
      }
      return result;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<int> cekTransactionUseId(
    String idUser,
  ) async {
    int cekTrans;
    var response = await http.get(
      Uri.parse("$baseUrl/get_transaksi.php?id_user=$idUser"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );
    if (response.statusCode == 200) {
      cekTrans = json.decode(response.body)['code'];
      return cekTrans;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<DataTransactionModel>> getDataTransactionUseIdTransAndIdUser(
      String id_trans, String idUser) async {
    var response = await http.get(
      Uri.parse(
          "$baseUrl/get_transaksi.php?id_transaksi=$id_trans&id_user=$idUser"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    // print(response.body);

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['result'];
      List<DataTransactionModel> result = [];

      for (var item in data) {
        result.add(DataTransactionModel.fromJson(item));
      }
      return result;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
