import 'package:flutter/material.dart';
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/models/user_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/services/data_unit_service.dart';
import 'package:go_rent/views/pages/home/category_page.dart';
import 'package:go_rent/views/pages/home/detail_page.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/confirm_whatsapp.dart';
import 'package:go_rent/views/widgets/loading.dart';
import 'package:go_rent/views/widgets/product_card.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    loadProducts();
    super.initState();
  }

  List<String> listCat = [
    'All',
    'Roda Dua',
    'Roda Empat',
  ];

  bool isLoading = false;
  List<DataUnitModel> products = [];

  Future<void> loadProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      products = await DataUnitService().getDataUnit();
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
    UserModel user = authProvider.user;

    Widget header() {
      return Container(
        height: 120.0,
        padding: const EdgeInsets.only(top: 25.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          color: primaryColor,
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 20.0,
            ),
            Image.network(
              "https://ui-avatars.com/api/?name=${user.username}&color=7F9CF5&background=random&rounded=true&size=60",
              width: 60.0,
              height: 60.0,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Selamat Datang",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "${user.username}",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: semibold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget searchInput() {
      return Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Autocomplete<DataUnitModel>(
            fieldViewBuilder:
                (context, textEditingController, focusNode, onFieldSubmitted) {
              return TextFormField(
                controller: textEditingController,
                focusNode: focusNode,
                onFieldSubmitted: (text) => onFieldSubmitted(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Cari macam kendaraan disini',
                  labelStyle: const TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                  ),
                ),
              );
            },
            initialValue: const TextEditingValue(text: ''),
            onSelected: (DataUnitModel value) {
              AccessWhatsApp.confirmWhatsApp(context, user, value.nama!);
            },
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<DataUnitModel>.empty();
              }
              return products.where((DataUnitModel option) {
                return option.nama
                    .toString()
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase());
              });
            },
            displayStringForOption: (option) {
              return option.nama!;
            },
            optionsViewBuilder: (context, onSelected, options) => Align(
              alignment: Alignment.topLeft,
              child: Material(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(4.0),
                  ),
                ),
                child: Container(
                  width: constraints.biggest.width,
                  margin: const EdgeInsets.only(top: 10.0),
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12.0),
                          ),
                          border: Border.all(
                            width: 1.0,
                            color: Colors.grey[300]!,
                          ),
                        ),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: options.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            bool selected =
                                AutocompleteHighlightedOption.of(context) ==
                                    index;
                            DataUnitModel option = options.elementAt(index);

                            return InkWell(
                              onTap: () => onSelected(option),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: selected
                                      ? Theme.of(context).focusColor
                                      : null,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      index == 0 ? 12 : 0,
                                    ),
                                    topRight: Radius.circular(
                                      index == 0 ? 12 : 0,
                                    ),
                                    bottomLeft: Radius.circular(
                                      index == options.length - 1 ? 12 : 0.0,
                                    ),
                                    bottomRight: Radius.circular(
                                      index == options.length - 1 ? 12 : 0.0,
                                    ),
                                  ),
                                ),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      option.gambar!,
                                    ),
                                  ),
                                  title: Text("${option.nama}"),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      );
    }

    Widget body() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text("Tidak ada kendaraan ?"),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Ayo cari kendaraan rental disini",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: semibold,
              ),
            ),
          ),

          // SEARCH
          searchInput(),

          Container(
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listCat.length,
              itemExtent: 130,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryPage(idKat: index),
                            ));
                      },
                      child: Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFD2D2D2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("${listCat[index]}")),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          const SizedBox(
            height: 5.0,
          ),

          // KATALOG PRODUCT
          const Padding(
            padding: EdgeInsets.only(left: 10, bottom: 20),
            child: Text(
              "Kendaraan Terbaik",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(
                  width: 5.0,
                ),
                isLoading
                    ? const LoadingWidget()
                    : Row(
                        children: products
                            .map((product) => ProductCard(product))
                            .toList(),
                      ),
                const SizedBox(
                  width: 5.0,
                ),
              ],
            ),
          ),

          // POPULAR PRODUCT
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "Rekomendasi",
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(id_unit: products[index].idUnit),
                      ),
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 10),
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
                              image: NetworkImage(products[index].gambar!),
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
                                "${products[index].nama}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: semibold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Rp${NumberFormat('#,###').format(products[index].hargasewa)}"
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
        ],
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
