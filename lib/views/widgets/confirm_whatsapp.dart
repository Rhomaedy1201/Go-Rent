import 'package:flutter/material.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/utils/go_to_whatsapp.dart';
import 'package:go_rent/views/themes/colors.dart';

class AccessWhatsApp {
  static void confirmWhatsApp(
    BuildContext context,
    UserModel userLogin,
    String label,
  ) async {
    bool confirm = false;
    String? message;

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Lanjutkan transaksi ke WhatsApp'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  initialValue: message,
                  decoration: const InputDecoration(
                    labelText: 'Ketik pesan untuk penjual',
                    labelStyle: TextStyle(
                      color: Colors.blueGrey,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueGrey,
                      ),
                    ),
                    helperText: "* opsional",
                    helperStyle: TextStyle(color: alertColor),
                  ),
                  onChanged: (value) {
                    message = value;
                  },
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Tidak"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: () {
                confirm = true;
                Navigator.pop(context);
              },
              child: const Text("Iya"),
            ),
          ],
        );
      },
    );

    // await showModalBottomSheet<void>(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return Container(
    //       padding: const EdgeInsets.all(30.0),
    //       child: Wrap(
    //         children: [
    //           SizedBox(
    //             width: MediaQuery.of(context).size.width,
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: <Widget>[
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );

    if (confirm) {
      String sendMessage =
          'Halo kak, perkenalkan saya, ${userLogin.username} dengan email ${userLogin.email}, ingin bertanya-tanya mengenai kendaraan $label. \n$message \nTerimakasih.';

      GoToWhatsApp().launchWhatsApp(sendMessage);
    }
  }
}
