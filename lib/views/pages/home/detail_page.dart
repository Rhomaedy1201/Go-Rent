import 'package:flutter/material.dart';
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/services/data_unit_service.dart';
import 'package:go_rent/views/pages/payment/checkout_screen.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/confirm_whatsapp.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  var id_unit;
  DetailPage({super.key, this.id_unit});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    print(widget.id_unit);
    getData();
  }

  int jmlWaktusewa = 1;

  bool isLoading = false;
  List<DataUnitModel> data = [];

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      data = await DataUnitService().getDataUseId(id: widget.id_unit);
    } catch (e) {
      print("cek $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    Widget ImageItem() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: NetworkImage(data[index].gambar!),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      );
    }

    Widget vehicleDetails() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${data[index].nama}",
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        const Text(
                          "disewakan",
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: greyColor,
                          ),
                        ),
                        Text(
                          "Rp${NumberFormat('#,###').format(data[index].hargasewa)}"
                              .replaceAll(",", "."),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: greenColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Jumlah Waktu Sewa"),
                    Container(
                      width: 130,
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFFEBEBEB),
                            blurRadius: 2,
                            offset: Offset(0, 0), // Shadow position
                          ),
                        ],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (jmlWaktusewa <= 1) {
                                } else {
                                  jmlWaktusewa -= 1;
                                }
                              });
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Color(0xFFBDD6C0),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(
                                Icons.remove,
                                size: 20,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          Text(
                            "$jmlWaktusewa  hari",
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (jmlWaktusewa >= 7) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 3),
                                      backgroundColor: Color(0xFFEF9218),
                                      content: Text(
                                        'Maximal pemesanan hanya 1minggu atau 7 hari!!!',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                } else {
                                  jmlWaktusewa += 1;
                                }
                              });
                            },
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 20,
                  color: greyColor,
                ),
                const Text(
                  "Rincian kendaraan :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: greyColor,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "jenis kendaraan :",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Stok Tersedia :",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data[index].jeniskendaraan}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "${data[index].stok} unit",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    }

    Widget bottomNavigationBar() {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 0,
        ),
        color: Colors.white,
        width: double.infinity,
        // height: 60,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Rp${NumberFormat('#,###').format(data[index].hargasewa)}"
                            .replaceAll(",", "."),
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: bold,
                          color: greenColor,
                        ),
                      ),
                      Text(
                        "/Hari",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: medium,
                          color: greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 160,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Metode pembayaran :"),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        AccessWhatsApp.confirmWhatsApp(
                                          context,
                                          authProvider.user,
                                          data[index].nama!,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: greenColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.whatsapp),
                                          SizedBox(width: 5),
                                          Text("Whatsapp"),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: double.infinity,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CheckoutScreen(
                                              idUnit: data[index].idUnit,
                                              jmlWaktusewa: jmlWaktusewa,
                                              subTotal: jmlWaktusewa *
                                                  int.parse(data[index]
                                                      .hargasewa
                                                      .toString()),
                                            ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryColor,
                                      ),
                                      child: const Text("Bayar Sekarang"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: const Size(double.infinity, 45),
                      backgroundColor: primaryColor,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(18)),
                      ),
                    ),
                    child: Text(
                      "Sewa Sekarang",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: semibold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: lightColor,
      bottomNavigationBar: bottomNavigationBar(),
      appBar: AppBar(
        title: const Text("Detal item"),
        backgroundColor: primaryColor,
        toolbarHeight: 75,
      ),
      body: isLoading
          ? const Center(
              child: LoadingWidget(),
            )
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageItem(),
                vehicleDetails(),
              ],
            )),
    );
  }
}
