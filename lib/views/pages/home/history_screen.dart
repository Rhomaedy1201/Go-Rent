import 'package:flutter/material.dart';
import 'package:go_rent/models/data_transaction_model.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/services/data_transaction_service.dart';
import 'package:go_rent/views/pages/home/main_page.dart';
import 'package:go_rent/views/pages/payment/payment_screen.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/confirm_whatsapp.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    loadTransaksi();
    super.initState();
  }

  bool isLoading = false;
  List<DataTransactionModel> transaksi = [];
  int? cekTrans;

  Future<void> loadTransaksi() async {
    setState(() {
      isLoading = true;
    });

    try {
      transaksi = await DataTransactionService()
          .getDataTransactionUseIdUser(widget.user.idUser!);
      cekTrans = await DataTransactionService()
          .cekTransactionUseId(widget.user.idUser!);
      print(cekTrans);
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    Widget header() {
      return Container(
        height: 100.0,
        padding: const EdgeInsets.only(top: 21.0, left: 20.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          color: primaryColor,
        ),
        child: Row(
          children: [
            Text(
              "History",
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: semibold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    Widget body() {
      return isLoading
          ? const LoadingWidget()
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transaksi.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              id_transaksi: transaksi[index].idTransaksi,
                              id_user: widget.user.idUser,
                            ),
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: const Color(0xFFDFDFDF),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("${transaksi[index].nama}"),
                              Text("${transaksi[index].tanggalTransaksi}"),
                            ],
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            height: 1,
                            color: const Color(0xFFC0C0C0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: (transaksi[index].statusPembayaran ==
                                          "Belum dibayar")
                                      ? const Color(0xDFFBC6C3)
                                      : const Color(0xFFCEFDCF),
                                  borderRadius: BorderRadius.circular(7),
                                ),
                                child: Text(
                                  "${transaksi[index].statusPembayaran}",
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  AccessWhatsApp.confirmWhatsApp(
                                    context,
                                    authProvider.user,
                                    transaksi[index].nama!,
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: greenColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.whatsapp,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "Chat Pemilik",
                                        style: TextStyle(
                                            color: Color(0xFFF0F0F0),
                                            fontSize: 13,
                                            fontWeight: medium),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
    }

    return RefreshIndicator(
      onRefresh: () => loadTransaksi(),
      child: ListView(
        children: [
          header(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              cekTrans == 400
                  ? Center(
                      child: Container(
                        width: 240,
                        height: 350,
                        // color: Colors.amber,
                        child: Column(
                          children: [
                            Lottie.asset('assets/lottie/empty.json'),
                            Text(
                              "History Transaksi Masih kosong silahkan melakukan transaksi, pilih unit yang anda suka!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: medium,
                                color: greyColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const MainPage()),
                                  (Route<dynamic> route) => false,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(130, 25),
                                backgroundColor: primaryColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Cari Unit"),
                                  SizedBox(width: 4),
                                  Icon(
                                    Icons.search_off_outlined,
                                    size: 20,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : body(),
            ],
          ),
        ],
      ),
    );
  }
}
