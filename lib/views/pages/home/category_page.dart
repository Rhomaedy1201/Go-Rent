import 'package:flutter/material.dart';
import 'package:go_rent/models/category_modal.dart';
import 'package:go_rent/services/service_category.dart';
import 'package:go_rent/views/pages/home/detail_page.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:intl/intl.dart';

class CategoryPage extends StatefulWidget {
  var idKat;
  CategoryPage({super.key, this.idKat});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> listCat = [
    'All',
    'Roda Dua',
    'Roda Empat',
  ];

  int isActive = 0;
  bool isLoading = false;

  List<CategoryModal> resultCategory = [];
  Future<void> _getCategory() async {
    setState(() {
      isLoading = true;
    });

    if (widget.idKat == 0) {
      resultCategory = await ServiceCategory().getCategory();
    } else if (widget.idKat == 1) {
      resultCategory = await ServiceCategory().getCategoryId(idKategori: "1");
    } else {
      resultCategory = await ServiceCategory().getCategoryId(idKategori: "2");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getCategory();
    print(widget.idKat);
    setState(() {
      isActive = widget.idKat;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget menuCat() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: listCat.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isActive = index;
                      widget.idKat = index;
                    });
                    _getCategory();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD2D2D2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: 115,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Center(
                      child: Text(
                        "${listCat[index]}",
                        style: isActive == index
                            ? TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: greenColor,
                              )
                            : TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
              ],
            );
          },
        ),
      );
    }

    Widget items() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: resultCategory.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(id_unit: resultCategory[index].idUnit),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
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
                        width: 125,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE0E0E0),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(resultCategory[index].gambar!),
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
                              "${resultCategory[index].nama}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: semibold,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "Rp${NumberFormat('#,###').format(resultCategory[index].hargasewa)}"
                                      .replaceAll(",", "."),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: bold,
                                    color: greenColor,
                                  ),
                                ),
                                Text(
                                  "/hari",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: medium,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    }

    Widget body() {
      return SingleChildScrollView(
        child: Column(
          children: [
            menuCat(),
            items(),
          ],
        ),
      );
    }

    return isLoading
        ? const Scaffold(
            body: Center(child: LoadingWidget()),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text("Kategori Kendaraan"),
              backgroundColor: primaryColor,
              toolbarHeight: 75,
            ),
            body: body(),
          );
  }
}
