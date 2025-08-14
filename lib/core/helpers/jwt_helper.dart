import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:darto_template/core/helpers/dotenv.dart';

abstract class JwtHelper {
  static Future<String> generateJwtToken(Map<String, dynamic> payload) async {
    try {
      final jwt = JWT(payload);

      final secretJwt = dotenv('JWT_SECRET');
      final ttl = dotenv('USER_TOKEN_TTL');

      // Sign it (default with HS256 algorithm)
      final token = jwt.sign(
        SecretKey(secretJwt),
        expiresIn: Duration(hours: int.parse(ttl)),
      );
      return token;
    } on JWTExpiredException {
      print('jwt expired');
      throw Exception('JWT expired');
    } on JWTException catch (ex) {
      print(ex.message); // ex: invalid signature
      throw Exception('JWT error');
    } catch (e) {
      print(e);
      throw Exception('Unknown error');
    }
  }

  static Future<Map<String, dynamic>> verifyJwtToken(String token) async {
    try {
      final secretJwt = dotenv('JWT_SECRET');
      // Verify a token
      final jwt = JWT.verify(token, SecretKey(secretJwt));
      return jwt.payload as Map<String, dynamic>;
    } on JWTExpiredException {
      print('jwt expired');
      throw Exception('JWT expired');
    } on JWTException catch (ex) {
      print(ex.message); // ex: invalid signature
      throw Exception('JWT error');
    } catch (e) {
      print(e);
      throw Exception('Unknown error');
    }
  }
}
