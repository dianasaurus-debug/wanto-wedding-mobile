import 'package:dream_wedding_app/Models/galeri.dart';
import 'package:dream_wedding_app/Models/review.dart';

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
  late String kind;
  late String rating_mean;
  late List<Review>? reviews = [];

  Vendor({
    this.id = 0 ,
    this.nama = '',
    this.cover = '',
    this.harga = '',
    this.deskripsi = '',
    this.category_id = 0,
    this.nominal_dp = '',
    this.nama_kategori = '',
    this.kind = '',
    this.rating_mean = '0'

}) : this.galeries = [];

  Vendor.fromJson(Map<String, dynamic> json)
      : nama = json['nama'],
        id = json['id'],
        cover = json['cover'],
        harga = json['harga'],
        category_id = json['category_id'],
        galeries = json["galeri"] == null ? null : List<Galeri>.from(json["galeri"].map((x) => new Galeri.fromJson(x))),
        reviews = json["reviews"] == null ? [] : List<Review>.from(json["reviews"].map((x) => new Review.fromJson(x))),
        nominal_dp = json['nominal_dp'],
        deskripsi = json['deskripsi'],
        kind = json['kind'],
        rating_mean = json['rating_mean'],
        nama_kategori = json['category']['nama_kategori'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama': nama,
    'cover': cover,
    'harga': harga,
    'nominal_dp' : nominal_dp,
    'category_id': category_id,
    'deskripsi': deskripsi,
    'rating_mean' : rating_mean
  };
}