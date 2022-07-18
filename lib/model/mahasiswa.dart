class Mahasiswa {
  int? id;
  String? name;
  String? nim;
  String? universitas;
  String? jurusan;

  Mahasiswa({this.id, this.name, this.nim, this.universitas, this.jurusan});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['name'] = name;
    map['nim'] = nim;
    map['universitas'] = universitas;
    map['jurusan'] = jurusan;

    return map;
  }

  Mahasiswa.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.name = map['name'];
    this.nim = map['nim'];
    this.universitas = map['universitas'];
    this.jurusan = map['jurusan'];
  }
}
