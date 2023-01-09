class CategoryModal {
  CategoryModal({
    this.idUnit,
    this.nama,
    this.gambar,
    this.jeniskendaraan,
    this.stok,
    this.hargasewa,
    this.idKategori,
  });

  String? idUnit;
  String? nama;
  String? gambar;
  String? jeniskendaraan;
  String? stok;
  int? hargasewa;
  String? idKategori;

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        idUnit: json["id_unit"],
        nama: json["nama"],
        gambar: json["gambar"],
        jeniskendaraan: json["jeniskendaraan"],
        stok: json["stok"],
        hargasewa: json["hargasewa"],
        idKategori: json["id_kategori"],
      );

  Map<String, dynamic> toJson() => {
        "id_unit": idUnit,
        "nama": nama,
        "gambar": gambar,
        "jeniskendaraan": jeniskendaraan,
        "stok": stok,
        "hargasewa": hargasewa,
        "id_kategori": idKategori,
      };
}
