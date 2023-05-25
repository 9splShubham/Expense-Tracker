import 'package:expense_tracker/model/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DbHelper {
  late Database _db;

  /// SIGN UP

  static const String DB_Name = 'MYData';
  static const int Version = 10;
  static const String Table_SignUpData = 'signUpData';
  static const String S_ID = 'id';
  static const String UserID = 'userId';
  static const String L_Name = 'name';
  static const String L_Email = 'email';
  static const String L_Password = 'password';

  /// ADD DATA
  static const String Table_UserData = 'userData';
  static const String U_ID = 'id';
  static const String U_UserID = 'userId';
  static const String U_Date = 'date';
  static const String U_Time = 'time';
  static const String U_Type = 'type';
  static const String U_Amount = 'amount';
  static const String U_Category = 'category';
  static const String U_PaymentMethod = 'paymentMethod';
  static const String U_Status = 'status';
  static const String U_Note = 'note';

  Future<Database> get db async {
    /*   if (_db != null) {
      return _db;
    }*/
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
    await db.execute("CREATE TABLE $Table_SignUpData ("
        " $S_ID INTEGER PRIMARY KEY , "
        " $UserID TEXT , "
        " $L_Name TEXT, "
        " $L_Email TEXT, "
        " $L_Password TEXT"
        ")");

    await db.execute("CREATE TABLE $Table_UserData ("
        " $U_ID INTEGER PRIMARY KEY  , "
        " $U_UserID TEXT  , "
        " $U_Date TEXT, "
        " $U_Time TEXT ,"
        " $U_Type TEXT,"
        " $U_Amount INTEGER,"
        " $U_Category TEXT,"
        " $U_PaymentMethod TEXT,"
        " $U_Status TEXT,"
        " $U_Note TEXT "
        ")");
  }

  /// SAVE LOGIN DETAILS

  Future<int> saveSignUpData(SignUpModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_SignUpData, user.toJson());
    return res;
  }

  Future<int> insertData(AddDataModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_UserData, user.toJson());
    return res;
  }

  Future<List<AddDataModel>> getItems(String? token) async {
    var dbClient = await db;
    var res = await dbClient
        .rawQuery("SELECT * FROM $Table_UserData WHERE $U_UserID = ?", [token]);
    try {
      List<AddDataModel> mAddDataModel = List<AddDataModel>.from(
          res.map((model) => AddDataModel.fromJson(model)));
      return mAddDataModel;
    } catch (e) {
      return [];
    }
  }
}
