class User {
  final String nama_depan;
  final String nama_belakang;
  final String email;
  final int id;
  final String alamat;
  final String profile_photo_path;


  User(this.id, this.nama_depan,this.nama_belakang,this.email, this.alamat, this.profile_photo_path);

  User.fromJson(Map<String, dynamic> json)
      : nama_depan = json['nama_depan'],
        id = json['id'],
        nama_belakang = json['nama_belakang'],
        email = json['email'],
        alamat = json['alamat'],
  profile_photo_path = json['profile_photo_path'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama_depan': nama_depan,
    'nama_belakang': nama_belakang,
    'email': email,
    'alamat' : alamat,
    'profile_photo_path' : profile_photo_path
  };
}