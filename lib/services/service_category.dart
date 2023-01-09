import 'dart:convert';
import 'dart:developer';

import 'package:go_rent/models/category_modal.dart';
import 'package:go_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;

class ServiceCategory {
  Future<List<CategoryModal>> getCategoryId(
      {required String idKategori}) async {
    List<CategoryModal> result = [];

    try {
      var response = await http.get(
        Uri.parse("$baseUrl/get_kategori.php?id_kategori=$idKategori"),
      );

      print(response.body);

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['result'];

        data.forEach((element) {
          result.add(CategoryModal.fromJson(element));
        });

        return result;
      } else {
        log(response.statusCode.toString());
      }

      return result;
    } catch (e) {
      log(e.toString());
    }

    return result;
  }

  Future<List<CategoryModal>> getCategory() async {
    List<CategoryModal> result = [];

    try {
      var response = await http.get(
        Uri.parse("$baseUrl/get_kategori.php"),
      );

      print(response.body);

      if (response.statusCode == 200) {
        List data = json.decode(response.body)['result'];

        data.forEach((element) {
          result.add(CategoryModal.fromJson(element));
        });

        return result;
      } else {
        log(response.statusCode.toString());
      }

      return result;
    } catch (e) {
      log(e.toString());
    }

    return result;
  }
}
