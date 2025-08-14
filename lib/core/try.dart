import 'package:darto/darto.dart';
import 'package:darto_template/core/errors/error_api.dart';
import 'package:darto_template/core/errors/result_handler.dart';

Future<T?> tryApi<T>(
  Future<T> Function() action,
  Response res,
) async {
  try {
    return await action();
  } on ErrorApi catch (e) {
    ResultHandler.errorHanlder(res, e);
  } catch (e) {
    ResultHandler.errorHanlder(res, e);
  }
  return null;
}
