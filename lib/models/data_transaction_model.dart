class DataTransactionModel {
  DataTransactionModel({
    this.idTransaksi,
    this.idUser,
    this.username,
    this.noHp,
    this.alamat,
    this.role,
    this.idUnit,
    this.nama,
    this.gambar,
    this.jeniskendaraan,
    this.jumlahroda,
    this.hargasewa,
    this.tanggalTransaksi,
    this.banyakdisewa,
    this.lamaSewa,
    this.statusSewa,
    this.idBank,
    this.namaBank,
    this.noRekening,
    this.namaPemilik,
    this.buktiPembayaran,
    this.totalPembayaran,
    this.statusPembayaran,
  });

  String? idTransaksi;
  String? idUser;
  String? username;
  String? noHp;
  String? alamat;
  String? role;
  String? idUnit;
  String? nama;
  String? gambar;
  String? jeniskendaraan;
  String? jumlahroda;
  String? hargasewa;
  String? tanggalTransaksi;
  int? banyakdisewa;
  int? lamaSewa;
  String? statusSewa;
  String? idBank;
  String? namaBank;
  String? noRekening;
  String? namaPemilik;
  String? buktiPembayaran;
  int? totalPembayaran;
  String? statusPembayaran;

  factory DataTransactionModel.fromJson(Map<String, dynamic> json) =>
      DataTransactionModel(
        idTransaksi: json["id_transaksi"],
        idUser: json["id_user"],
        username: json["username"],
        noHp: json["no_hp"],
        alamat: json["alamat"],
        role: json["role"],
        idUnit: json["id_unit"],
        nama: json["nama"],
        gambar: json["gambar"],
        jeniskendaraan: json["jeniskendaraan"],
        jumlahroda: json["jumlahroda"],
        hargasewa: json["hargasewa"],
        tanggalTransaksi: json["tanggal_transaksi"],
        banyakdisewa: json["banyakdisewa"],
        lamaSewa: json["lama_sewa"],
        statusSewa: json["status_sewa"],
        idBank: json["id_bank"],
        namaBank: json["nama_bank"],
        noRekening: json["no_rekening"],
        namaPemilik: json["nama_pemilik"],
        buktiPembayaran: json["bukti_pembayaran"],
        totalPembayaran: json["total_pembayaran"],
        statusPembayaran: json["status_pembayaran"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "id_user": idUser,
        "username": username,
        "no_hp": noHp,
        "alamat": alamat,
        "role": role,
        "id_unit": idUnit,
        "nama": nama,
        "gambar": gambar,
        "jeniskendaraan": jeniskendaraan,
        "jumlahroda": jumlahroda,
        "hargasewa": hargasewa,
        "tanggal_transaksi": tanggalTransaksi,
        "lama_sewa": lamaSewa,
        "status_sewa": statusSewa,
        "id_bank": idBank,
        "nama_bank": namaBank,
        "no_rekening": noRekening,
        "nama_pemilik": namaPemilik,
        "bukti_pembayaran": buktiPembayaran,
        "total_pembayaran": totalPembayaran,
        "status_pembayaran": statusPembayaran,
      };
}
