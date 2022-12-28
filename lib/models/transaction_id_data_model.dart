class TransactionIdDataModel {
  TransactionIdDataModel({
    this.idTransaksi,
    this.status,
  });

  int? idTransaksi;
  String? status;

  factory TransactionIdDataModel.fromJson(Map<String, dynamic> json) =>
      TransactionIdDataModel(
        idTransaksi: json["id_transaksi"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "status": status,
      };
}
