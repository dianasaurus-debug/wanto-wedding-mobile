class BankAccount {
  final String nama_bank;
  final String nomor_rekening;
  final String acc_holder;
  final int id;


  BankAccount(this.id, this.nama_bank,this.nomor_rekening,this.acc_holder);

  BankAccount.fromJson(Map<String, dynamic> json)
      : nama_bank = json['nama_bank'],
        id = json['id'],
        nomor_rekening = json['nomor_rekening'],
        acc_holder = json['acc_holder'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama_bank': nama_bank,
    'nomor_rekening': nomor_rekening,
    'acc_holder': acc_holder,
  };
}