import 'package:dream_wedding_app/Models/bank_account.dart';

class Payment {
  late String nominal;
  late String kode_unik;
  late String bukti_pembayaran;
  late String nomor_rekening;
  late String nama_pembayar;
  late int jenis_pembayaran;
  late int status_pembayaran;
  late int booking_id;
  late String confirmed_at;
  late BankAccount bankAccount;
  late int id;


  Payment({this.id = 0, this.nominal = '', this.bukti_pembayaran = '',this.nomor_rekening = '',this.nama_pembayar = '',
      this.jenis_pembayaran = 0, this.status_pembayaran = 0, this.booking_id = 0,this.confirmed_at = '', this.kode_unik = ''}) : this.bankAccount = BankAccount() ;

  Payment.fromJson(Map<String, dynamic> json)
      : nominal = json['nominal'],
        kode_unik = json['kode_unik'],
        id = json['id'],
        bukti_pembayaran = json['bukti_pembayaran'],
        nomor_rekening = json['nomor_rekening'],
        jenis_pembayaran = json['jenis_pembayaran'],
        status_pembayaran = json['status_pembayaran'],
        booking_id = json['booking_id'],
        confirmed_at = json['confirmed_at'],
        bankAccount = new BankAccount.fromJson(json["bank_account"]),
        nama_pembayar = json['nama_pembayar'];



  Map<String, dynamic> toJson() => {
    'id' : id,
    'nominal': nominal,
    'kode_unik': kode_unik,
    'bukti_pembayaran': bukti_pembayaran,
    'jenis_pembayaran': jenis_pembayaran,
    'nomor_rekening': nomor_rekening,
    'nama_pembayar': nama_pembayar,
    'status_pembayaran' : status_pembayaran,
    'booking_id' : booking_id,
    'confirmed_at' : confirmed_at,
  };
}