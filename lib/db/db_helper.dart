import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String dbName = 'aboutUs.db';

    String dbPath = join(path, dbName);
    print(dbPath);
    var db = await openDatabase(dbPath, version: 1, onCreate: onCreate);
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE Propriedade (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    image TEXT,
    nome TEXT
);''';

    await db.execute(sql);

    sql =
        "INSERT INTO Propriedade (image, nome) VALUES ('assets/images/Ezequiel.png', 'José Ezequiel');";
    await db.execute(sql);

    sql =
        "INSERT INTO Propriedade (image, nome) VALUES ('assets/images/Lara.png', 'Lara Ivine');";
    await db.execute(sql);

    sql =
        "INSERT INTO Propriedade (image, nome) VALUES ('assets/images/Clara.png', 'Maria Clara');";
    await db.execute(sql);

    sql =
        "INSERT INTO Propriedade (image, nome) VALUES ('assets/images/Karla.png', 'Maria Karla');";
    await db.execute(sql);
  }
}
