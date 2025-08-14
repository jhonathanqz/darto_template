import 'package:darto_template/modules/user/domain/model/user_model.dart';

abstract class UserRepository {
  Future<bool> createUser(UserModel userModel);
  Future<UserModel?> getUserByEmail(String email);
  Future<List<UserModel>> findUsers();
}
