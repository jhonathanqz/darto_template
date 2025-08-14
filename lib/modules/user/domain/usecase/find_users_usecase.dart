import 'package:darto_template/modules/user/domain/model/user_model.dart';
import 'package:darto_template/modules/user/domain/repositories/contract/user_repository.dart';
import 'package:result_dart/result_dart.dart';

class FindUsersUsecase {
  final UserRepository _userRepository;

  FindUsersUsecase({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  Future<Result<List<UserModel>>> call() async {
    try {
      final result = await _userRepository.findUsers();
      return Success(result);
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
