import 'package:flutter/material.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  late UserModel _user;

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> register({
    required String username,
    required String noHp,
    required String email,
    required String alamat,
    required String password,
  }) async {
    try {
      // UserModel user = await AuthService().register(
      //   username: username,
      //   noHp: noHp,
      //   email: email,
      //   alamat: alamat,
      //   password: password,
      // );
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel user =
          await AuthService().login(email: email, password: password);
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> update({
    required String idUser,
    required String username,
    required String noHp,
    required String alamat,
  }) async {
    try {
      UserModel user = await AuthService().update(
        idUser: idUser,
        username: username,
        noHp: noHp,
        alamat: alamat,
      );
      _user = user;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
