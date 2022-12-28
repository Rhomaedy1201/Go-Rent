import 'package:flutter/material.dart';
import 'package:go_rent/models/history_model.dart';
import 'package:go_rent/utils/currency_format.dart';
import 'package:go_rent/views/themes/colors.dart';
import 'package:go_rent/views/themes/font_weights.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile(this.history, {super.key});
  final HistoryModel history;

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.history.nama!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: bold,
                  fontSize: 18,
                ),
              ),
              Text(
                widget.history.tanggal!,
                style: TextStyle(
                  fontWeight: light,
                  fontSize: 12,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Text(
            widget.history.status!,
            textAlign: TextAlign.right,
            style: TextStyle(
                color: widget.history.status == 'Selesai'
                    ? greenColor
                    : Colors.yellow[800]),
          ),
        ],
      ),
    );
  }
}
