import 'package:darto_template/modules/user/domain/model/user_model.dart';
import 'package:darto_template/modules/user/domain/repositories/contract/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class CreateUserUsecase {
  final UserRepository _userRepository;

  CreateUserUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<Result<bool>> call(UserModel userModel) async {
    try {
      final result = await _userRepository.createUser(userModel);
      return Success(result);
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
