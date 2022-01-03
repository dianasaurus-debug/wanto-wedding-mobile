class BankAccount {
  late String nama_bank;
  late String nomor_rekening;
  late String acc_holder;
  late int id;


  BankAccount({this.id = 0, this.nama_bank = '',this.nomor_rekening = '',this.acc_holder = ''});

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