class Kategori {
  final String nama_kategori;
  final int id;


  Kategori(this.nama_kategori,this.id);

  Kategori.fromJson(Map<String, dynamic> json)
      : nama_kategori = json['nama_kategori'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama_kategori': nama_kategori,
  };
}