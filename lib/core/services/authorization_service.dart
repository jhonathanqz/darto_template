import 'package:darto/darto.dart';
import 'package:darto_template/core/errors/result_handler.dart';
import 'package:darto_template/core/helpers/dotenv.dart';
import 'package:darto_template/core/helpers/jwt_helper.dart';
import 'package:darto_template/core/helpers/message_helper.dart';

abstract class AuthorizationService {
  static Future<void> verifiyToken(
    Request req,
    Response res,
    NextFunction next,
  ) async {
    final token = req.headers.authorization;
    if (token == null || token.isEmpty) {
      final errorMessage = await MessageHelper.errorHandler(
        'missing.authorization',
        [],
        req.headers,
      );
      return ResultHandler.error.unauthorized(res, errorMessage);
    }
    // Verifique o token aqui (por exemplo, decodificando e validando)
    final isValid = await _validateToken(token, req, res);
    if (!isValid) {
      final errorMessage = await MessageHelper.errorHandler(
        'unauthorized',
        [],
        req.headers,
      );
      return ResultHandler.error.forbidden(res, errorMessage);
    }
    next();
  }

  static Future<bool> _validateToken(
    String token,
    Request req,
    Response res,
  ) async {
    String tokenApp = token;
    if (token.startsWith('Bearer static:')) {
      token = token.substring(14);
      final staticEnv = dotenv('STATIC_TOKEN');
      if (tokenApp != staticEnv) {
        final errorMessage = await MessageHelper.errorHandler(
          'incorrect.static.token',
          [],
          req.headers,
        );
        ResultHandler.error.forbidden(res, errorMessage);
        return false;
      }
      return true;
    } else if (token.startsWith('Bearer ')) {
      tokenApp = token.substring(7);
      final validateToken = await _validateJwtToken(tokenApp);
      if (validateToken == null) {
        final errorMessage = await MessageHelper.errorHandler(
          'incorrect.token',
          [],
          req.headers,
        );
        ResultHandler.error.forbidden(res, errorMessage);
        return false;
      }
      validateToken.forEach((key, value) {
        // req.param[key] = value;
        req.headers.append(key, value);
      });

      return true;
    }

    final errorMessage = await MessageHelper.errorHandler(
      'incorrect.token',
      [],
      req.headers,
    );
    ResultHandler.error.forbidden(res, errorMessage);
    return false;
  }

  static Future<Map<String, dynamic>?> _validateJwtToken(String token) async {
    try {
      final payload = await JwtHelper.verifyJwtToken(token);
      return payload;
    } catch (e) {
      return null;
    }
  }
}
