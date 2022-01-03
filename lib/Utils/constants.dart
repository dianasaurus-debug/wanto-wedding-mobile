import 'package:flutter/material.dart';

const API_URL = 'http://192.168.43.204:8000/api';
const IMG_URL = 'http://192.168.43.204:8000/images/uploads/';
const IMG_URL_KATALOG = 'http://192.168.43.204:8000/images/uploads/katalog/';
const IMG_URL_VENDOR = 'http://192.168.43.204:8000/images/uploads/vendor/';
const IMG_URL_BUKTI = 'http://192.168.43.204:8000/images/bukti_pembayaran/';
const verifications = ['','Terverifikasi', 'Belum diverifikasi'];
const verification_color = [Colors.green,Colors.green,Colors.yellow];
const status_booking = [
 'Belum Bayar DP',
 'Menunggu verifikasi DP',
 'Menunggu pembayaran Pelunasan',
'Menunggu verifikasi pelunasan',
 'Pelunasan terverifikasi',
'Dibatalkan',
'Event berlangsung',
'Event selesai, menunggu rating',
'Sudah dirate',
];
const status_color = [
  Colors.blueGrey,
  Colors.lightBlue,
  Colors.lightBlue,
  Colors.deepOrangeAccent,
  Colors.green,
  Colors.red,
  Colors.blue,
  Colors.blue,
  Colors.green,
];
// const API_URL = 'http://10.0.18.185:8000/api';
// const IMG_URL = 'http://10.0.18.185:8000/images/uploads/';
// const IMG_URL_KATALOG = 'http://10.0.18.185:8000/images/uploads/katalog/';
// const IMG_URL_VENDOR = 'http://10.0.18.185:8000/images/uploads/vendor/';