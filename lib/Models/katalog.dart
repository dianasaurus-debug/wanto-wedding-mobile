class Katalog {
  final String judul;
  final String cover;
  final String isi;
  final int id;


  Katalog(this.judul, this.cover,this.isi, this.id);

  Katalog.fromJson(Map<String, dynamic> json)
      : judul = json['judul'],
        id = json['id'],
        cover = json['cover'],
        isi = json['isi'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'judul': judul,
    'cover': cover,
    'isi': isi,
  };
}