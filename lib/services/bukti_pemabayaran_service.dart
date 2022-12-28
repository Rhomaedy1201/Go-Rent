import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';
import 'package:go_rent/utils/base_url.dart';

class BuktiPembayaranService {
  GetConnect connect = GetConnect();
  Future<bool?> updateBuktiPembayaran({
    required String idTrans,
    required String idUser,
    required File image,
    required String statusPembayaran,
  }) async {
    bool result;
    try {
      // Uint8List imageBytes = await image.readAsBytesSync();
      final form = FormData({
        'bukti_pembayaran':
            MultipartFile(image, filename: 'bukti_pembayaran.png'),
      });
      final response = await connect.post(
          '$baseUrl/update_bukti_pembayaran.php?id_transaksi=$idTrans&id_user=$idUser&status_pembayaran=$statusPembayaran',
          form);
      print(response.body);
      if (response.statusCode == 200) {
        result = json.decode(response.body)[0]['type'];
        return result;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
