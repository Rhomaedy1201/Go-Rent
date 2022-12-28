import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:go_rent/utils/base_url.dart';
import 'package:http/http.dart' as http;
import 'package:go_rent/models/payment_method_data_model.dart';

class PaymentMethodService {
  Future<List<PaymentMethodDataModel>> getPayment() async {
    List<PaymentMethodDataModel> paymentResult = [];
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/get_metode_pembayaran.php"),
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );
      // print(response.body);
      if (response.statusCode == 200) {
        List data = json.decode(response.body)['result'];
        data.forEach((element) {
          paymentResult.add(PaymentMethodDataModel.fromJson(element));
        });
        return paymentResult;
      } else {
        throw Exception(response.statusCode);
      }
    } catch (e) {
      log(e.toString());
    }
    return paymentResult;
  }
}
