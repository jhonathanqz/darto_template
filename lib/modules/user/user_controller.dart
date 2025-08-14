import 'package:darto/darto.dart';
import 'package:darto_template/core/errors/result_handler.dart';
import 'package:darto_template/core/try.dart';
import 'package:darto_template/modules/user/infra/user_service.dart';

class UserController {
  final UserService _userService;

  UserController({
    required UserService userService,
  }) : _userService = userService;

  Future<void> create(Request req, Response res) async {
    await tryApi(() async {
      await _userService.createUser(req);
      ResultHandler.success.emptyOk(res);
    }, res);
  }

  Future<void> teste(Request req, Response res) async {
    await tryApi(() async {
      await Future.delayed(const Duration(seconds: 2));
      ResultHandler.success.ok(res, {
        'result': 'User created with id: 12345678',
      });
    }, res);
  }
}
