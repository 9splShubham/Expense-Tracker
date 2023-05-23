import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DbHelper {
  late Database _db;

  static const String DB_Name = 'myDb.db';
  static const String Table_UserData = 'userData';
  static const int Version = 3;
  static const String UserID = 'id';
  static const String U_Date = 'date';
  static const String U_Time = 'time';
  static const String U_Type = 'type';
  static const String U_Category = 'category';
  static const String U_PaymentMethod = 'paymentMethod';
  static const String U_Note = 'note';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_Name);
    var db = await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async {
    await db.execute("CREATE TABLE $Table_UserData ("
        " $UserID INTEGER PRIMARY KEY, "
        " $U_Date TEXT, "
        " $U_Time INTEGER ,"
        " $U_Type TEXT,"
        " $U_Category INTEGER,"
        " $U_PaymentMethod TEXT,"
        " $U_Note TEXT "
        ")");
  }
}
