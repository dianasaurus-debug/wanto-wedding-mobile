class ServiceTambahan {
  late String nama_service;
  late String harga;
  late bool is_check;
  late int id;


  ServiceTambahan({this.id = 0, this.nama_service = '',this.harga = '',this.is_check = false});

  ServiceTambahan.fromJson(Map<String, dynamic> json)
      : nama_service = json['nama_service'],
        id = json['id'],
        harga = json['harga'],
        is_check = json['is_check'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama_service': nama_service,
    'harga': harga,
    'is_check': is_check,
  };
}