import 'package:darto_template/modules/user/domain/model/user_model.dart';
import 'package:darto_template/modules/user/domain/repositories/contract/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class GetUserEmailUsecase {
  final UserRepository _userRepository;

  GetUserEmailUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<Result<UserModel>> call(String email) async {
    try {
      final result = await _userRepository.getUserByEmail(email);

      if (result == null) {
        return Failure(Exception('User not found'));
      }

      return Success(result);
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
