import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/models/payment_method_data_model.dart';
import 'package:go_rent/models/transaction_id_data_model.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/services/data_checkout_service.dart';
import 'package:go_rent/services/data_unit_service.dart';
import 'package:go_rent/services/payment_method_service.dart';
import 'package:go_rent/services/service_id_transaction.dart';
import 'package:go_rent/views/pages/payment/payment_screen.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatefulWidget {
  CheckoutScreen({this.idUnit, this.jmlWaktusewa, this.subTotal, super.key});
  var idUnit, jmlWaktusewa, subTotal;

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    getProduk();
    getIdUser();
    getIdTrans();
    getPayment();
    super.initState();
  }

  // inisisalisai waktu atau tanggal
  DateTime now = DateTime.now();

  // get id user menggunakan provider untuk passing ke payment
  AuthProvider? authProvider;
  getIdUser() async {
    authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  // get id Transaksi untuk menambahakan atau post ke payment/pembayaran
  bool isloading = false;
  var idTrans;
  var cekIdTrans;
  var idTransaksi;
  Future<void> getIdTrans() async {
    setState(() {
      isloading = true;
    });
    try {
      idTrans = await ServiceIdTransaction().getIdTransaction();
      idTransaksi = idTrans + 1;
      print(idTransaksi);
    } catch (e) {
      print(e);
    }
    setState(() {
      isloading = false;
    });
  }

  // get id pembayarn untuk passing ke pembayaran
  List<PaymentMethodDataModel> pay = [];
  Future<void> getPayment() async {
    setState(() {
      isloading = true;
    });

    try {
      pay = await PaymentMethodService().getPayment();
    } catch (e) {
      print("cek $e");
    }

    setState(() {
      isloading = false;
    });
  }

  // get data produk
  List<DataUnitModel> dataProduk = [];

  Future<void> getProduk() async {
    setState(() {
      isloading = true;
    });

    try {
      dataProduk = await DataUnitService().getDataUseId(id: widget.idUnit);
    } catch (e) {
      print("cek $e");
    }

    setState(() {
      isloading = false;
    });
  }

  // post transaksi untuk upload data dari checkout ke transaksi
  Future<void> postTransaction() async {
    setState(() {
      isloading = true;
    });

    try {
      var postTrans = await DataCheckoutService().postTransaction(
        id_transaksi: '${idTransaksi}',
        id_user: '${authProvider?.user.idUser}',
        id_unit: '${widget.idUnit}',
        tanggal: '${now.year}-${now.month}-${now.day}',
        banayakdisewa: '1',
        lama_sewa: '${widget.jmlWaktusewa}',
        status_sewa: 'Disewa',
        id_bank: '${pay[0].idBank}',
        bukti_pembayaran: '',
        total_pembayaran: '${widget.subTotal}',
        status_pembayaran: 'Belum dibayar',
      );
      print(idTransaksi);
      if (postTrans == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentScreen(
              id_transaksi: '${idTransaksi}',
              id_user: '${authProvider?.user.idUser}',
            ),
          ),
          ModalRoute.withName('payment'),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 4),
            backgroundColor: greenColor,
            content: Text(
              'Berhasil Checkout, Silahkan Melakukan Pembayaran!!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(seconds: 4),
            backgroundColor: alertColor,
            content: Text(
              'Checkout gagal!!!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    // Metode pembayaran
    Widget metodePembayaran() {
      return Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: pay.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 19,
                    vertical: 10,
                  ),
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.payments_rounded,
                          ),
                          const SizedBox(width: 10),
                          Text("Bank ${pay[index].namaBank}"),
                        ],
                      ),
                      const Icon(
                        Icons.check,
                        color: greenColor,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    // product
    Widget selectProduct() {
      return isloading
          ? const LoadingWidget()
          : ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: dataProduk.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0, bottom: 1),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 19, vertical: 10),
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFDBDBDB),
                          blurRadius: 3,
                          offset: Offset(0, 0), // Shadow position
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              image: NetworkImage(dataProduk[index].gambar!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${dataProduk[index].nama}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: semibold,
                                ),
                              ),
                              Text(
                                "Rp${NumberFormat('#,###').format(dataProduk[index].hargasewa)}"
                                    .replaceAll(",", "."),
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: bold,
                                  color: greenColor,
                                ),
                              ),
                              Text(
                                "${widget.jmlWaktusewa} Hari Penyewaan",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: semibold,
                                  color: greyColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
    }

    Widget dataPenyewa(
      String namaPenyewa,
      String noHp,
      String alamat,
    ) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(namaPenyewa),
                Text(noHp),
                Text(alamat),
              ],
            ),
          );
        },
      );
    }

    Widget rincianPembayaran() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SubTotal (x${widget.jmlWaktusewa} Hari Sewa) :",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  "Rp${NumberFormat('#,###').format(widget.subTotal)}"
                      .replaceAll(",", "."),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: semibold,
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget bottomBar() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        child: Container(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            onPressed: () {
              postTransaction();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            child: const Text(
              "Bayar Sekarang",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
      );
    }

    Widget body() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 5,
                ),
                child: Text(
                  "Metode Pembayaran",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: medium,
                  ),
                ),
              ),
              metodePembayaran(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 5,
                ),
                child: Text(
                  "Data Penyewa",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: medium,
                  ),
                ),
              ),
              dataPenyewa(
                user.username!,
                user.noHp!,
                user.alamat!,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 19,
                  vertical: 5,
                ),
                child: Text(
                  "Kendaraan yang disewa",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: medium,
                  ),
                ),
              ),
              selectProduct(),
              rincianPembayaran(),
            ],
          );
        },
      );
    }

    return isloading
        ? const Scaffold(
            body: Center(
              child: LoadingWidget(),
            ),
          )
        : Scaffold(
            backgroundColor: const Color(0xFFE8E8E8),
            bottomNavigationBar: bottomBar(),
            appBar: AppBar(
              title: const Text("Checkout"),
              backgroundColor: primaryColor,
              toolbarHeight: 75,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  body(),
                ],
              ),
            ),
          );
  }
}
