import 'package:flutter/material.dart';
import 'package:go_rent/models/data_unit_model.dart';
import 'package:go_rent/provider/auth_provider.dart';
import 'package:go_rent/views/pages/home/detail_page.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';
import 'package:go_rent/views/widgets/confirm_whatsapp.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard(this.product, {super.key});
  final DataUnitModel product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    return InkWell(
      // onTap: () => AccessWhatsApp.confirmWhatsApp(
      //     context, authProvider.user, widget.product.nama!),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(
              id_unit: widget.product.idUnit,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
        decoration: BoxDecoration(
          color: Color(0xFFDEDEDE),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.product.gambar!,
                width: 120,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              "Nama kendaraan",
              style: TextStyle(
                fontSize: 8.0,
                fontWeight: extralight,
              ),
            ),
            Text(
              widget.product.nama!,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: medium,
              ),
            ),
            Row(
              children: [
                Text(
                  "Rp${NumberFormat('#,###').format(widget.product.hargasewa)}"
                      .replaceAll(",", "."),
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: medium,
                    color: Colors.green,
                  ),
                ),
                Text(
                  "/Hari",
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: extralight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
