import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:test_flutter_application/entity/userModel.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;

  static final String DATABASE_NAME = "test.db";

  static final String TABLE_USER = 'userModel';
  static final String TABLE_ADDRESS = 'address';
  static final String CREATE_TABLE_USER =
      "CREATE TABLE $TABLE_USER(userId INTEGER PRIMARY KEY autoincrement , firstName TEXT,lastName TEXT)";

  static final String CREATE_TABLE_ADDRESS =
      "CREATE TABLE $TABLE_ADDRESS(addresId INTEGER PRIMARY KEY autoincrement , userId INTEGER, stree TEXT, city TEXT,state TEXT,zip INTEGER )";

  static Future<Database?> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE_NAME);

   _db = await openDatabase(path,
        version: 1, onCreate: _onCreate, onUpgrade: onUpgrade);
    return _db;
  }

  static Future<void> _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
      CREATE_TABLE_USER,
    );
    db.execute(
      CREATE_TABLE_ADDRESS,
    );
  }

  static Future<void> onUpgrade(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute('CREATE TABLE NameTable3 ...');
    }
    //onCreate(db, newVersion);
  }

  static Future<int> insertUser(UserModel task) async {
    print("insert function called");
    int result=0;
    try{

   result= await _db!.insert(TABLE_USER, task.toJson());

    }catch(e){
      print(e);
    }
    return result;
  }

  static  Future<int> updateUser(UserModel data, id) async {
    return await _db!.update(TABLE_USER, data.toJson(),
        where: 'userId = ?', whereArgs: [id]);
  }

  static  Future<int> updateAddress(Address data, id) async {
    return await _db!.update(TABLE_USER, data.toJson(),
        where: 'addresId = ?', whereArgs: [id]);}

  static Future<int> insertAddress(Address task) async {
    print("insert function called");
    int result=0;
    try{
      result= await _db!.insert(TABLE_ADDRESS, task.toJson());
    }catch(e){
      print(e);
    }
    return result;
  }
  static Future<int> deleteUser(UserModel task) async => await _db!
      .delete(TABLE_USER, where: 'userId = ?', whereArgs: [task.userId]);
  static Future<int> deleteAddress(var userId) async => await _db!
      .delete(TABLE_ADDRESS, where: 'userId = ?', whereArgs: [userId]);

  static Future<List> getAllUser() async {
    var dbClient = await _db;
    var result = await dbClient!.rawQuery('SELECT * FROM $TABLE_USER');
    return result.toList();
  }

  static Future<List> getAddressByUserId(var userId) async {
    var dbClient = await _db;
    var result = await dbClient!
        .rawQuery("SELECT * FROM $TABLE_ADDRESS where userId='$userId'");
    return result.toList();
  }
}
