import 'package:darto/darto.dart';
import 'package:get_it/get_it.dart';
import 'package:darto_template/core/interface/api_module.dart';
import 'package:darto_template/modules/user/domain/repositories/contract/user_repository.dart';
import 'package:darto_template/modules/user/domain/usecase/create_user_usecase.dart';
import 'package:darto_template/modules/user/domain/usecase/find_users_usecase.dart';
import 'package:darto_template/modules/user/domain/usecase/get_user_email_usecase.dart';
import 'package:darto_template/modules/user/domain/repositories/user_repository_impl.dart';
import 'package:darto_template/modules/user/infra/user_service.dart';
import 'package:darto_template/modules/user/schemas/user_schemas.dart';
// import 'package:darto_template/core/services/authorization_service.dart';
import 'package:darto_template/modules/user/user_controller.dart';
import 'package:zard_darto_middleware/zard_darto_middleware.dart';

class UserModule extends ApiModule {
  @override
  void onBinds(GetIt i) {
    i.registerFactory<UserRepository>(
      () => UserRepositoryImpl(database: i.get()),
    );
    i.registerFactory(() => CreateUserUsecase(userRepository: i.get()));
    i.registerFactory(() => FindUsersUsecase(userRepository: i.get()));
    i.registerFactory(() => GetUserEmailUsecase(userRepository: i.get()));
    i.registerFactory<UserService>(
      () => UserService(
        createUserUsecase: i(),
        findUsersUsecase: i(),
        getUserEmailUsecase: i(),
      ),
    );
    i.registerFactory(() => UserController(userService: i()));
  }

  @override
  void onConfigureRoutes(Router router, GetIt i) {
    final UserController controller = i.get();

    router.post(
      '/',
      validateRequestBody(userCreateSchema),
      controller.create,
    );

    router.get('/teste', controller.teste);
  }
}
