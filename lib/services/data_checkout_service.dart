import 'dart:convert';
import 'dart:developer';
import 'package:go_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;

class DataCheckoutService {
  Future<bool?> postTransaction({
    required String id_transaksi,
    required String id_user,
    required String id_unit,
    required String tanggal,
    required String banayakdisewa,
    required String lama_sewa,
    required String status_sewa,
    required String id_bank,
    required String bukti_pembayaran,
    required String total_pembayaran,
    required String status_pembayaran,
  }) async {
    bool result;
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/post_transaksi.php"),
        body: {
          'id_transaksi': '$id_transaksi',
          'id_user': '$id_user',
          'id_unit': '$id_unit',
          'tanggal': '$tanggal',
          'banyakdisewa': '$banayakdisewa',
          'lama_sewa': '$lama_sewa',
          'status_sewa': '$status_sewa',
          'id_bank': '$id_bank',
          'bukti_pembayaran': '$bukti_pembayaran',
          'total_pembayaran': '$total_pembayaran',
          'status_pembayaran': '$status_pembayaran',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        result = json.decode(response.body)[0]['type'];
        return result;
      } else {
        print(response.statusCode);
      }
      // return result;
    } catch (e) {
      log("ket = ${e.toString()}");
    }
    // return result;
  }
}
