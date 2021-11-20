class User {
  final String nama_depan;
  final String nama_belakang;
  final String email;
  final int id;


  User(this.id, this.nama_depan,this.nama_belakang,this.email);

  User.fromJson(Map<String, dynamic> json)
      : nama_depan = json['nama_depan'],
        id = json['id'],
        nama_belakang = json['nama_belakang'],
        email = json['email'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama_depan': nama_depan,
    'nama_belakang': nama_belakang,
    'email': email,
  };
}