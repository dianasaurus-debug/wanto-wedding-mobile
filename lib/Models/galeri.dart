class Galeri {
  final String filename;
  final int id;


  Galeri(this.id, this.filename);

  Galeri.fromJson(Map<String, dynamic> json)
      : filename = json['filename'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'filename': filename,
  };
}