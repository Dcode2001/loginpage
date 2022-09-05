import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  Database? db;

  Future<Database> CreateDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    print(path);

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, password TEXT)');
    });

    // db = database;
    return database;
  }

  loginuser(String username, String password) async {
    db = await CreateDatabase();

    String qry = "select * from Test where name = '$username' and password = '$password'";

    List l = await db!.rawQuery(qry);

    if(l.length>0)
      {
          return l.first;
      }
  }
}
