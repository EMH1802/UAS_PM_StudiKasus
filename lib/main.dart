import 'package:flutter/material.dart';
import 'database/db_helper.dart';
import 'form_mahasiswa.dart';
import 'list_mahasiswa.dart';
import 'model/mahasiswa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: ListMahasiswaPage(),
    );
  }
}
