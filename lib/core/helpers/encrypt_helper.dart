import 'package:bcrypt/bcrypt.dart';

class EncryptHelper {
  /// Criptografa a senha usando bcrypt
  static String encryptPassword(String password) {
    const int saltRounds = 10;
    final salt = BCrypt.gensalt(logRounds: saltRounds);
    return BCrypt.hashpw(password, salt);
  }

  /// Compara a senha com o hash armazenado
  static bool comparePassword(String password, String hash) {
    return BCrypt.checkpw(password, hash);
  }
}
