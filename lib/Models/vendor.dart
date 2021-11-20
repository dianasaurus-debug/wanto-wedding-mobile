import 'package:dream_wedding_app/Models/galeri.dart';

class Vendor {
  late String nama;
  late String cover;
  late String harga;
  late String deskripsi;
  late int id;
  late int category_id;
  late String nominal_dp;
  late List<Galeri>? galeries;
  late String nama_kategori;


  Vendor({
    this.id = 0 ,
    this.nama = '',
    this.cover = '',
    this.harga = '',
    this.deskripsi = '',
    this.category_id = 0,
    this.nominal_dp = '',
    this.nama_kategori = ''

}) : this.galeries = [];

  Vendor.fromJson(Map<String, dynamic> json)
      : nama = json['nama'],
        id = json['id'],
        cover = json['cover'],
        harga = json['harga'],
        category_id = json['category_id'],
        galeries = json["galeri"] == null ? null : List<Galeri>.from(json["galeri"].map((x) => new Galeri.fromJson(x))),
        nominal_dp = json['nominal_dp'],
        deskripsi = json['deskripsi'],
        nama_kategori = json['category']['nama_kategori'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama': nama,
    'cover': cover,
    'harga': harga,
    'nominal_dp' : nominal_dp,
    'category_id': category_id,
    'deskripsi': deskripsi,
  };
}