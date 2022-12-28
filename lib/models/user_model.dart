class UserModel {
  String? idUser;
  String? username;
  String? password;
  String? noHp;
  String? email;
  String? alamat;
  String? role;

  UserModel(
      {this.idUser,
      this.username,
      this.password,
      this.noHp,
      this.email,
      this.alamat,
      this.role});

  UserModel.fromJson(Map<String, dynamic> json) {
    idUser = json['id_user'];
    username = json['username'];
    password = json['password'];
    noHp = json['no_hp'];
    email = json['email'];
    alamat = json['alamat'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_user'] = this.idUser;
    data['username'] = this.username;
    data['password'] = this.password;
    data['no_hp'] = this.noHp;
    data['email'] = this.email;
    data['alamat'] = this.alamat;
    data['role'] = this.role;
    return data;
  }
}
