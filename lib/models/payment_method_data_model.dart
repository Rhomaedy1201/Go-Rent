class PaymentMethodDataModel {
  PaymentMethodDataModel({
    this.idBank,
    this.namaBank,
    this.noRekening,
    this.namaPemilik,
  });

  String? idBank;
  String? namaBank;
  String? noRekening;
  String? namaPemilik;

  factory PaymentMethodDataModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodDataModel(
        idBank: json["id_bank"],
        namaBank: json["nama_bank"],
        noRekening: json["no_rekening"],
        namaPemilik: json["nama_pemilik"],
      );

  Map<String, dynamic> toJson() => {
        "id_bank": idBank,
        "nama_bank": namaBank,
        "no_rekening": noRekening,
        "nama_pemilik": namaPemilik,
      };
}
