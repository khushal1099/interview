import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final DbHelper _obj = DbHelper._helper();

  DbHelper._helper();

  final dbname = 'users.db';

  factory DbHelper() {
    return _obj;
  }

  static DbHelper get instance => _obj;

  Database? database;

  Future<void> initDb() async {
    database = await openDatabase(
      dbname,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE "Users" ('
          '"id" INTEGER,'
          '"email" TEXT NOT NULL, '
          '"password" TEXT NOT NULL, '
          'PRIMARY KEY("id" AUTOINCREMENT))',
        );
      },
      singleInstance: true,
    );
  }

  Future<void> insertUser(String email, String password) async {
    var db = await openDatabase(dbname);
    List<Map<String, dynamic>> result = await db.query(
      'Users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    // If the quote doesn't exist, insert it into the database
    if (result.isEmpty) {
      await db.insert(
        'Users',
        {
          'email': email,
          'password': password,
        },
      );
    } else {
      // Quote already exists, handle accordingly
      print('Already Login');
    }
  }

  Future<void> logOutUser() async {
    var db = await openDatabase(dbname);
    await db.delete('Users');
  }
}
