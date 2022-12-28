class DataUnitModel {
  String? idUnit;
  String? nama;
  String? gambar;
  String? jeniskendaraan;
  String? jumlahroda;
  int? hargasewa;

  DataUnitModel(
      {this.idUnit,
      this.nama,
      this.gambar,
      this.jeniskendaraan,
      this.jumlahroda,
      this.hargasewa});

  DataUnitModel.fromJson(Map<String, dynamic> json) {
    idUnit = json['id_unit'];
    nama = json['nama'];
    gambar = json['gambar'];
    jeniskendaraan = json['jeniskendaraan'];
    jumlahroda = json['jumlahroda'];
    hargasewa = json['hargasewa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_unit'] = this.idUnit;
    data['nama'] = this.nama;
    data['gambar'] = this.gambar;
    data['jeniskendaraan'] = this.jeniskendaraan;
    data['jumlahroda'] = this.jumlahroda;
    data['hargasewa'] = this.hargasewa;
    return data;
  }
}
