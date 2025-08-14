import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class AuthHelper {
  static const String _passwordToken = '08642emdj039hffkefm39hf92398ffmkeonfe';
  static const String _stringToken = '8rhf9dhu4f20wo2h8dg302sn3g7d83dh3';

  /// Criptografa a senha com HMAC SHA-256 usando a chave definida.
  static String encryptPassword(String password) {
    final key = utf8.encode(_passwordToken);
    final bytes = utf8.encode(password);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    return digest.toString();
  }

  /// Gera um JWT assinado com Payload `params` e TTL em segundos.
  static String generateToken(
    Map<String, dynamic> params, {
    required Duration expiresIn,
  }) {
    final jwt = JWT(
      params,
    );
    return jwt.sign(
      SecretKey(_passwordToken),
      expiresIn: expiresIn,
    );
  }

  /// Valida um token JWT. Retorna o payload decodificado ou lança erro.
  static Map<String, dynamic> validateToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_passwordToken));
      return jwt.payload;
    } on JWTExpiredException {
      throw Exception('Token expirado');
    } on JWTException catch (e) {
      throw Exception('Token inválido: ${e.message}');
    }
  }

  /// Gera um token aleatório (hex de 10 bytes, cortado a 10 caracteres).
  static String randomToken() {
    final bytes = List<int>.generate(10, (_) => Random.secure().nextInt(256));
    return base64Url.encode(bytes).substring(0, 10);
  }

  /// Criptografa uma string usando AES-256-CBC com IV gerado aleatoriamente.
  static String encryptString(String text) {
    // Not implemented: requer biblioteca como pointycastle para AES-CBC.
    throw UnimplementedError(
      'AES encryption requires a package like pointycastle.',
    );
  }

  /// Descriptografa uma string criptografada com AES-256-CBC.
  static String decryptString(String encrypted) {
    // Not implemented: requer biblioteca como pointycastle para AES-CBC.
    throw UnimplementedError(
      'AES decryption requires a package like pointycastle.',
    );
  }

  /// Gera um hash HMAC-SHA256 para a string com a chave _stringToken.
  static String generateHash(String input) {
    final key = utf8.encode(_stringToken);
    final bytes = utf8.encode(input);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    return digest.toString();
  }
}
