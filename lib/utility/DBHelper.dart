import 'dart:developer';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper {
  DBHelper.internal();

  static final DBHelper instance = DBHelper.internal();

  factory DBHelper() => instance;

  static String noteTable = "shrimadbhagwadgita";
  final _version = 1;
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  Future<Database> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'shrimadbhagwadgita.db');
    log(dbPath);
    var openDb = await openDatabase(dbPath, version: _version,
        onCreate: (Database db, int version) async {
      createDB(db);
    }, onUpgrade: (Database db, int oldVersion, int newVersion) async {
    });
    log('db initialize');
    return openDb;
  }

  void createDB(Database db) async {
    await db.execute(
        "CREATE TABLE IF NOT EXISTS `events` (`id` INTEGER PRIMARY KEY AUTOINCREMENT,"
        "`event_name` varchar(255)  NOT NULL,`event_date` datetime DEFAULT NULL,`event_bio` longtext ,"
        "`event_location` varchar(255)  DEFAULT NULL,`event_image` varchar(255)  DEFAULT NULL,"
        "`event_category` int DEFAULT NULL,`event_objective` longtext ,`event_live_link` varchar(512)  DEFAULT NULL,"
        "`event_detail_header` varchar(255)  DEFAULT NULL,`event_registration_available` tinyint(1) DEFAULT '1',"
        "`parent_id` int NOT NULL DEFAULT '0',`created_at` timestamp NULL DEFAULT NULL,"
        "`updated_at` timestamp NULL DEFAULT NULL,name varchar(1000),description text,icon text);");


  }
}
