import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_rent/models/history_model.dart';
import 'package:go_rent/utils/base_url.dart';

class HistoryService {
  Future<List<HistoryModel>> gethistory(
    int idUser,
  ) async {
    var response = await Dio().get(
      "$baseUrl/riwayat_transaksi.php?id_user=$idUser",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    print(response.data);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.data)['data'];
      List<HistoryModel> products = [];

      for (var item in data) {
        products.add(HistoryModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
