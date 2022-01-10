class Katalog {
  final String judul;
  final String cover;
  final String isi;
  final int tema_id;
  final int id;


  Katalog(this.judul, this.cover,this.isi, this.tema_id, this.id);

  Katalog.fromJson(Map<String, dynamic> json)
      : judul = json['judul'],
        id = json['id'],
        tema_id = json['tema_id'],
        cover = json['cover'],
        isi = json['isi'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'judul': judul,
    'tema_id': tema_id,
    'cover': cover,
    'isi': isi,
  };
}