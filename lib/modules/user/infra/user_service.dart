import 'package:darto/darto.dart';
import 'package:darto_template/core/check_schema.dart';
import 'package:darto_template/core/errors/error_api.dart';
import 'package:darto_template/core/helpers/encrypt_helper.dart';
import 'package:darto_template/core/helpers/message_helper.dart';
import 'package:darto_template/modules/user/domain/model/user_model.dart';
import 'package:darto_template/modules/user/domain/usecase/create_user_usecase.dart';
import 'package:darto_template/modules/user/domain/usecase/find_users_usecase.dart';
import 'package:darto_template/modules/user/domain/usecase/get_user_email_usecase.dart';
import 'package:darto_template/modules/user/schemas/user_schemas.dart';
import 'package:darto_template/modules/user/shared/helpers/user_errors.dart';

class UserService {
  final CreateUserUsecase _createUserUsecase;
  final FindUsersUsecase _findUsersUsecase;
  final GetUserEmailUsecase _getUserEmailUsecase;

  UserService({
    required CreateUserUsecase createUserUsecase,
    required FindUsersUsecase findUsersUsecase,
    required GetUserEmailUsecase getUserEmailUsecase,
  }) : _createUserUsecase = createUserUsecase,
       _findUsersUsecase = findUsersUsecase,
       _getUserEmailUsecase = getUserEmailUsecase;

  Future<dynamic> createUser(Request req) async {
    final headers = req.headers;
    final bodyParams = await req.body;

    final schemaResult = await checkSchema(userCreateSchema, bodyParams);
    if (schemaResult == null) {
      final errorMessage = await MessageHelper.errorHandler(
        'invalid.schema',
        [
          {'schema': schemaResult},
        ],
        headers,
      );

      throw ExceptionApi(errorMessage);
    }

    final passwordEcrypt = EncryptHelper.encryptPassword(
      schemaResult['password'],
    );

    final createdUser = await _createUserUsecase.call(
      UserModel.createUser(
        email: schemaResult['email'],
        password: passwordEcrypt,
        name: schemaResult['name'],
      ),
    );

    if (createdUser.isError()) {
      final errorMessage = await MessageHelper.errorHandler(
        'user.created.error',
        [],
        headers,
      );
      throw UserException(errorMessage);
    }

    return;
  }

  Future findUsers(Request req, Response res) async {}

  Future getUserEmail(Request req, Response res) async {
    final headers = req.headers;
    final query = req.query;

    final schemaResult = await checkSchema(getUserEmailSchema, query);
    if (schemaResult == null) {
      final errorMessage = await MessageHelper.errorHandler(
        'invalid.schema',
        [
          {'schema': schemaResult},
        ],
        headers,
      );

      throw ExceptionApi(errorMessage);
    }

    final userDatabase = await _getUserEmailUsecase.call(query['email'] ?? '');
    if (userDatabase.isError()) {
      final errorMessage = await MessageHelper.errorHandler(
        'user.not.found',
        [],
        headers,
      );

      throw UserException(errorMessage);
    }

    return userDatabase.getOrNull();
  }
}
