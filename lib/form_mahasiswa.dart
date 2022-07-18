import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'model/mahasiswa.dart';

class FormMahasiswa extends StatefulWidget {
  final Mahasiswa? mahasiswa;

  FormMahasiswa({this.mahasiswa});

  @override
  _FormMahasiswaState createState() => _FormMahasiswaState();
}

class _FormMahasiswaState extends State<FormMahasiswa> {
  DbHelper db = DbHelper();

  TextEditingController? name;
  TextEditingController? lastName;
  TextEditingController? nim;
  TextEditingController? universitas;
  TextEditingController? jurusan;

  @override
  void initState() {
    name = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.name);

    nim = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.nim);

    universitas = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.universitas);

    jurusan = TextEditingController(
        text: widget.mahasiswa == null ? '' : widget.mahasiswa!.jurusan);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Mahasiswa'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nim,
              decoration: InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: universitas,
              decoration: InputDecoration(
                  labelText: 'Universitas',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: jurusan,
              decoration: InputDecoration(
                  labelText: 'Jurusan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              child: (widget.mahasiswa == null)
                  ? Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertMahasiswa();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertMahasiswa() async {
    if (widget.mahasiswa != null) {
      //update
      await db.updateMahasiswa(Mahasiswa.fromMap({
        'id': widget.mahasiswa!.id,
        'name': name!.text,
        'nim': nim!.text,
        'universitas': universitas!.text,
        'jurusan': jurusan!.text
      }));
      Navigator.pop(context, 'update');
    } else {
      //insert
      await db.saveMahasiswa(Mahasiswa(
        name: name!.text,
        nim: nim!.text,
        universitas: universitas!.text,
        jurusan: jurusan!.text,
      ));
      Navigator.pop(context, 'save');
    }
  }
}
