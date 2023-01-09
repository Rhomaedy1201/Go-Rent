class HistoryModel {
  String? idTransaksi;
  String? tanggal;
  String? noHp;
  String? banyakdisewa;
  String? status;
  String? username;
  String? email;
  String? alamat;
  String? nama;
  String? gambar;
  String? jeniskendaraan;
  String? stok;
  String? hargasewa;

  HistoryModel({
    this.idTransaksi,
    this.tanggal,
    this.noHp,
    this.banyakdisewa,
    this.status,
    this.username,
    this.email,
    this.alamat,
    this.nama,
    this.gambar,
    this.jeniskendaraan,
    this.stok,
    this.hargasewa,
  });

  HistoryModel.fromJson(Map<String, dynamic> json) {
    idTransaksi = json['id_transaksi'];
    tanggal = json['tanggal'];
    noHp = json['no_hp'];
    banyakdisewa = json['banyakdisewa'];
    status = json['status'];
    username = json['username'];
    email = json['email'];
    alamat = json['alamat'];
    nama = json['nama'];
    gambar = json['gambar'];
    jeniskendaraan = json['jeniskendaraan'];
    stok = json['stok'];
    hargasewa = json['hargasewa'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_transaksi'] = this.idTransaksi;
    data['tanggal'] = this.tanggal;
    data['no_hp'] = this.noHp;
    data['banyakdisewa'] = this.banyakdisewa;
    data['status'] = this.status;
    data['username'] = this.username;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['nama'] = this.nama;
    data['gambar'] = this.gambar;
    data['jeniskendaraan'] = this.jeniskendaraan;
    data['stok'] = this.stok;
    data['hargasewa'] = this.hargasewa;
    return data;
  }
}
