import 'package:darto_template/config/databases/database.dart';
import 'package:darto_template/modules/user/domain/model/user_model.dart';
import 'package:darto_template/modules/user/domain/repositories/contract/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Database _database;
  UserRepositoryImpl({
    required Database database,
  }) : _database = database;

  String collectionName = 'users';

  @override
  Future<bool> createUser(UserModel userModel) async {
    try {
      final db = await _database.db;
      final result = await db
          .collection(collectionName)
          .insertOne(userModel.toCreate());
      return result.isSuccess;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> findUsers() async {
    try {
      final db = await _database.db;
      final result = await db.collection(collectionName).find().toList();
      return result.map((user) => UserModel.fromMap(user)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final db = await _database.db;
      final result = await db.collection(collectionName).findOne({
        'email': email,
      });
      return result != null ? UserModel.fromMap(result) : null;
    } catch (e) {
      rethrow;
    }
  }
}
