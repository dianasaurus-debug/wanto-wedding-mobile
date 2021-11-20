class Payment {
  final String nominal;
  final String bukti_pembayaran;
  final String nomor_rekening;
  final String nama_pembayar;
  final int jenis_pembayaran;
  final int status_pembayaran;
  final int booking_id;
  final int bank_account_id;
  final String confirmed_at;
  final int id;


  Payment(this.id, this.nominal,this.bukti_pembayaran,this.nomor_rekening,this.nama_pembayar,
      this.jenis_pembayaran, this.status_pembayaran, this.booking_id, this.bank_account_id, this.confirmed_at);

  Payment.fromJson(Map<String, dynamic> json)
      : nominal = json['nominal'],
        id = json['id'],
        bukti_pembayaran = json['bukti_pembayaran'],
        nomor_rekening = json['nomor_rekening'],
        jenis_pembayaran = json['jenis_pembayaran'],
        status_pembayaran = json['status_pembayaran'],
        booking_id = json['booking_id'],
        bank_account_id = json['bank_account_id'],
        confirmed_at = json['confirmed_at'],
        nama_pembayar = json['nama_pembayar'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nominal': nominal,
    'bukti_pembayaran': bukti_pembayaran,
    'jenis_pembayaran': jenis_pembayaran,
    'nomor_rekening': nomor_rekening,
    'nama_pembayar': nama_pembayar,
    'status_pembayaran' : status_pembayaran,
    'booking_id' : booking_id,
    'bank_account_id' : bank_account_id,
    'confirmed_at' : confirmed_at,
  };
}