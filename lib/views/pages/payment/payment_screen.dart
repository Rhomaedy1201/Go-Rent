import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_rent/models/data_transaction_model.dart';
import 'package:go_rent/services/bukti_pemabayaran_service.dart';
import 'package:go_rent/services/data_transaction_service.dart';
import 'package:go_rent/views/pages/home/main_page.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class PaymentScreen extends StatefulWidget {
  PaymentScreen({this.id_transaksi, this.id_user, super.key});
  var id_transaksi, id_user;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<String> listLangkah2 = [
    'Copy no rekening di atas',
    'Tranfer melalu Atm / Brimo',
    'Bukti Transfer silahkan di foto atau Screenshot',
    'Lalu klik upload bukti pembayaran pilih foto bukti transfer',
    'Pembayaran berhasil',
  ];

  @override
  void initState() {
    print(widget.id_transaksi);
    print(widget.id_user);
    super.initState();
    loadTransaksi();
  }

  File? image;

  Future<void> getFileImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imagePicked =
        await _picker.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      setState(() {
        image = File(imagePicked.path);
        updateBuktiPembayaran();
        loadTransaksi();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: greenColor,
            content: Text(
              'Berhasil Update bukti transaksi',
              textAlign: TextAlign.center,
            ),
          ),
        );
      });
      setState(() {
        loadTransaksi();
      });
    } else {
      print("image null");
      image;
    }
  }

  bool isLoading = false;
  List<DataTransactionModel> transaksi = [];

  Future<void> loadTransaksi() async {
    setState(() {
      isLoading = true;
    });

    try {
      transaksi = await DataTransactionService()
          .getDataTransactionUseIdTransAndIdUser(
              widget.id_transaksi, widget.id_user);
      setState(() {});
    } catch (e) {
      print(e);
    }

    setState(() {
      isLoading = false;
    });
  }

  bool? buktiPembayaran;
  Future<void> updateBuktiPembayaran() async {
    setState(() {
      isLoading = true;
    });

    try {
      buktiPembayaran = await BuktiPembayaranService().updateBuktiPembayaran(
        idTrans: transaksi[0].idTransaksi!,
        idUser: transaksi[0].idUser!,
        image: image!,
        statusPembayaran: "Pembayaran Berhasil",
      );
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // info pembayaran
    Widget pembayaran() {
      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return isLoading
                  ? const LoadingWidget()
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Info Pembayaran",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: semibold,
                              color: greyColor,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Dimohon untuk segera menyelesaikan pembayaran anda dengan sebesar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: regular,
                              color: greyColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            color: cardColor,
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "Rp ${NumberFormat('#,###').format(transaksi[index].totalPembayaran)}"
                                        .replaceAll(",", "."),
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: extrabold,
                                      color: greenColor,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Divider(
                                        color: Color(0xFF81B4AE),
                                        thickness: 1,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${transaksi[index].statusPembayaran}",
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          transaksi[index].buktiPembayaran != ""
                                              ? const Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color: greenColor,
                                                )
                                              : const Icon(
                                                  Icons.close,
                                                  size: 20,
                                                  color: Colors.redAccent,
                                                )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 80,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC6C6C6),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://e-geber.com/assets/post/img/1605748217_atm-bri.png"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Bank ${transaksi[index].namaBank}",
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "${transaksi[index].namaPemilik}",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("No.Rek  "),
                              InkWell(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text: "${transaksi[index].noRekening}"
                                          .toString()));
                                },
                                child: Row(
                                  children: [
                                    Text("${transaksi[index].noRekening}"),
                                    const SizedBox(width: 7),
                                    const Icon(
                                      Icons.copy,
                                      size: 17,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 10),
                          const Text("Bukti Pembayaran"),
                          Text(
                            "👇",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: regular,
                            ),
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              getFileImage();
                            },
                            child: Container(
                              width: 150,
                              height: 160,
                              decoration: BoxDecoration(
                                  color: Color(0xFFE3E3E3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: transaksi[index].buktiPembayaran != ""
                                  ? Container(
                                      width: 150,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        // color: Colors.amber,
                                        image: DecorationImage(
                                          image: MemoryImage(
                                            base64Decode(transaksi[index]
                                                .buktiPembayaran!),
                                          ),
                                        ),
                                      ),
                                    )
                                  : image != null
                                      ? Container(
                                          width: 150,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            image: DecorationImage(
                                              image: FileImage(image!),
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            const SizedBox(height: 30),
                                            Text(
                                              "Upload bukti pembayaran",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: regular,
                                              ),
                                            ),
                                            const SizedBox(height: 7),
                                            const Icon(
                                              Icons.add_photo_alternate_rounded,
                                              size: 30,
                                            )
                                          ],
                                        ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Langkah-langkah untuk menyelesaikan pembayaran:",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.black),
                              ),
                              const SizedBox(height: 8),
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: listLangkah2.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    "${index + 1}. ${listLangkah2[index]}",
                                    style: const TextStyle(
                                        fontSize: 13, color: greyColor),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
            },
          ),
        ],
      );
    }

    Widget bottomBar() {
      return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: transaksi.length,
            itemBuilder: (context, index) {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const MainPage()),
                      (Route<dynamic> route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: transaksi[index].buktiPembayaran == ""
                    ? const Text("Bayar Nanti")
                    : const Text("Kembali Ke Home"),
              );
            },
          ));
    }

    return isLoading
        ? const Scaffold(
            body: Center(
              child: LoadingWidget(),
            ),
          )
        : Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: bottomBar(),
            appBar: AppBar(
              title: const Text("Payment"),
              backgroundColor: primaryColor,
              toolbarHeight: 75,
            ),
            body: RefreshIndicator(
              onRefresh: () => loadTransaksi(),
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: const Color(0xFFE8E8E8),
                  ),
                  pembayaran(),
                ],
              ),
            ),
          );
  }
}
