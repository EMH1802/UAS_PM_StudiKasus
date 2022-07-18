import 'package:flutter/material.dart';
import 'form_mahasiswa.dart';

import 'database/db_helper.dart';
import 'model/mahasiswa.dart';

class ListMahasiswaPage extends StatefulWidget {
  const ListMahasiswaPage({Key? key}) : super(key: key);

  @override
  _ListMahasiswaPageState createState() => _ListMahasiswaPageState();
}

class _ListMahasiswaPageState extends State<ListMahasiswaPage> {
  List<Mahasiswa> listMahasiswa = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    _getAllMahasiswa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Data Mahasiswa"),
        ),
      ),
      body: ListView.builder(
          itemCount: listMahasiswa.length,
          itemBuilder: (context, index) {
            Mahasiswa mahasiswa = listMahasiswa[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                ),
                title: Text('${mahasiswa.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Nim: ${mahasiswa.nim}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Universitas: ${mahasiswa.universitas}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Jurusan: ${mahasiswa.jurusan}"),
                    )
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _openFormEdit(mahasiswa);
                          },
                          icon: Icon(Icons.edit)),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin Ingin Menghapus Data ${mahasiswa.name}")
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteMahasiswa(mahasiswa, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya")),
                              TextButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  Future<void> _getAllMahasiswa() async {
    var list = await db.getAllMahasiswa();

    setState(() {
      listMahasiswa.clear();

      list!.forEach((mahasiswa) {
        listMahasiswa.add(Mahasiswa.fromMap(mahasiswa));
      });
    });
  }

  Future<void> _deleteMahasiswa(Mahasiswa mahasiswa, int position) async {
    await db.deleteMahasiswa(mahasiswa.id!);
    setState(() {
      listMahasiswa.removeAt(position);
    });
  }

  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormMahasiswa()));
    if (result == 'save') {
      await _getAllMahasiswa();
    }
  }

  Future<void> _openFormEdit(Mahasiswa mahasiswa) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormMahasiswa(mahasiswa: mahasiswa)));
    if (result == 'update') {
      await _getAllMahasiswa();
    }
  }
}
