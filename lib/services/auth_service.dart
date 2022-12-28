import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/utils/base_url.dart';

class AuthService {
  Future<UserModel> register({
    required String username,
    required String noHp,
    required String email,
    required String alamat,
    required String password,
  }) async {
    var response = await Dio().get(
      "$baseUrl/register.php?username=$username&password=$password&no_hp=$noHp&email=$email&alamat=$alamat",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.data);
      UserModel user = UserModel.fromJson(data['data'][0]);

      print(user);

      return user;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    var response = await Dio().get(
      "$baseUrl/login.php?email=$email&password=$password",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    print('$baseUrl/login.php?email=$email&password=$password');

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.data);
      UserModel user = UserModel.fromJson(data['data'][0]);

      print(user);

      return user;
    } else {
      throw Exception('Exception: ${response.statusMessage}');
    }
  }

  Future<UserModel> update({
    required String idUser,
    required String username,
    required String noHp,
    required String alamat,
  }) async {
    var response = await Dio().get(
      "$baseUrl/update_profile.php?id_user=$idUser&username=$username&no_hp=$noHp&alamat=$alamat",
      options: Options(
        headers: {
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      Map data = jsonDecode(response.data);
      UserModel user = UserModel.fromJson(data['data'][0]);

      print(user);

      return user;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
