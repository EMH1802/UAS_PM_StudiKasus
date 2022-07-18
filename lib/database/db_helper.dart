import 'package:crud_mahasiswa/model/mahasiswa.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tableMahasiswa';
  final String columnId = 'id';
  final String columnName = 'name';
  final String columnNim = 'nim';
  final String columnUniversitas = 'universitas';
  final String columnJurusan = 'jurusan';

  DbHelper._internal();
  factory DbHelper() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'kontak.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnName TEXT,"
        "$columnNim TEXT,"
        "$columnUniversitas TEXT,"
        "$columnJurusan TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, mahasiswa.toMap());
  }

  //read database
  Future<List?> getAllMahasiswa() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnName,
      columnNim,
      columnUniversitas,
      columnJurusan
    ]);

    return result.toList();
  }

  //update database
  Future<int?> updateMahasiswa(Mahasiswa mahasiswa) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, mahasiswa.toMap(),
        where: '$columnId = ?', whereArgs: [mahasiswa.id]);
  }

  //hapus database
  Future<int?> deleteMahasiswa(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
