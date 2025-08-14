import 'package:mongo_dart/mongo_dart.dart';
import 'package:darto_template/core/helpers/dotenv.dart';

class Database {
  static Db? _database;

  Future<Db> get db async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Db> _initDatabase() async {
    try {
      final uriMongo = dotenv('URI_MONGO_DATABASE');
      final db = await Db.create(uriMongo);
      await db.open();
      return db;
    } catch (e) {
      print('*Error initializing database: $e');
      rethrow;
    }
  }
}
