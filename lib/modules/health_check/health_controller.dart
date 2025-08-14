import 'package:darto/darto.dart';
import 'package:darto_template/core/errors/result_handler.dart';

class HealthController {
  Future<void> healthCheck(Request req, Response res) async {
    ResultHandler.success.ok(res, {'status': 'Ok'});
  }
}
