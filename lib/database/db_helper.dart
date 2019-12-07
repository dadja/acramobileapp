import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:acra/models/village.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database _db;

  static const int databaseVersion = 3;

  static const String DB_NAME = "acra.db";
  static const String TABLE = "Village";
  static const String ID = "id";
  //TABLE DATA
  static const String PAYS = "pays";
  static const String NOM = "nom";
  static const String REGION = "region";
  static const String DEPARTEMENT = "departement";
  static const String ARRONDISSEMENT = "arrondissement";
  static const String COMMUNE = "commune";

  Future<Database> get db async {
    if (_db != null) {
      print("already exist copy database");
      return _db;
    }
    print("null create database");
    _db = await initDB();
    return _db;
  }

  initDB() async {
    print("database initDB");
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate, onUpgrade: _onUpGrade);
    return db;
  }

  _onUpGrade(Database db, int oldVersion, int newVersion) async {
    print("database oldVersion $oldVersion / newVersion $newVersion");
    List<Village> prevvillages;

    if (newVersion != oldVersion)
      await db.execute('DROP TABLE IF EXISTS $TABLE');

    // if (newVersion != oldVersion) {
    //   prevvillages = await getVillages();
    //   await db.execute('DROP TABLE IF EXISTS $TABLE');
    // }

    print("database dropped");
    _onCreate(db, newVersion);

    //TODO my custom is here
    // if (prevvillages.length != 0) {
    //   print("database villages size is ${prevvillages.length}");
    //   prevvillages.forEach((village) {
    //     db.insert(TABLE, village.toMapForDb());
    //   });
    // } else {
    //   print("database villages is empty");
    // }
  }

  _onCreate(Database db, int version) async {
    print("database create new one");
    await db.execute(
      "CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY,"
      "$PAYS TEXT,"
      "$REGION TEXT,"
      "$DEPARTEMENT TEXT,"
      "$ARRONDISSEMENT TEXT,"
      "$COMMUNE TEXT,"
      "$NOM TEXT)",
    );
  }

  Future<Village> save(Village enrol) async {
    var dbClient = await db;
//     enrol.id = await dbClient.insert(TABLE, enrol.toJson());
    enrol.id = await dbClient.insert(TABLE, enrol.toMapForDb());
    print("data saved id is  ${enrol.id}");
    return enrol;
  }

  Future<List<Village>> getVillages() async {
    var dbClient = await db;
    //nice and sleek query ..
    //  List<Map> maps = await dbClient.query(TABLE,columns: [ID,NOM,PRENOMS]);//get only id nom and prenoms
    List<Map> maps = await dbClient.query(TABLE); //get all values
    //raw query
    print("data enrols found size is ${maps.length} ");
    return maps.map((village) => Village.fromJson(village)).toList();

    // List<Village> villages = [];
    // if (maps.length > 0) {
    //   for (int i = 0; i < maps.length; i++) {
    //     villages.add(Village.fromJson(maps[i]));
    //   }
    // }
    // return villages;
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  // Future<int> queryRowCount() async {
  //   var dbClient = await db;
  //   return Sqflite.firstIntValue(await db.r('SELECT COUNT(*) FROM $table'));
  // }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
  }

  Future<int> update(Village enrol) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, enrol.toMapForDb(),
        where: '$ID = ?', whereArgs: [enrol.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
