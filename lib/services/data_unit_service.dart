import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/utils/base_url.dart';

class DataUnitService {
  Future<List<DataUnitModel>> getDataUnit() async {
    var response = await http.get(
      Uri.parse(
        "$baseUrl/data_unit.php",
      ),
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<DataUnitModel> products = [];

      for (var item in data) {
        products.add(DataUnitModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<DataUnitModel>> getDataUseId({required String id}) async {
    var response = await http.get(
      Uri.parse("$baseUrl/detail_unit.php?id_unit=$id"),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
    );

    if (response.statusCode == 200) {
      List data = json.decode(response.body)['data'];
      List<DataUnitModel> products = [];

      for (var item in data) {
        products.add(DataUnitModel.fromJson(item));
      }

      return products;
    } else {
      throw Exception(response.statusCode);
    }
  }
}
