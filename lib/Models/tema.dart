class Tema {
  final String nama_tema;
  final int id;


  Tema(this.nama_tema,this.id);

  Tema.fromJson(Map<String, dynamic> json)
      : nama_tema = json['nama_tema'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'nama_tema': nama_tema,
  };
}