import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class StringHelper {
  /// Remove todos os caracteres que não são dígitos.
  static String onlyNumbers(String document) {
    return document.replaceAll(RegExp(r'[^\d]+'), '');
  }

  /// Retorna o valor ou o valor padrão caso seja nulo/vazio.
  static T valueOrDefault<T>(T? field, T defaultValue) {
    if (field == null) return defaultValue;
    if (field is String && field.isEmpty) return defaultValue;
    return field;
  }

  /// Retorna o valor caso seja maior que o valor padrão, caso contrário retorna o padrão.
  static num valueGreaterThanZero(num field, num defaultValue) {
    return field > defaultValue ? field : defaultValue;
  }

  /// Gera um hash MD5 de uma string.
  static String generateHashMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// Capitaliza a primeira letra.
  static String capitalize(String? text) {
    if (text == null || text.isEmpty) return text ?? '';
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  /// Gera um UUID numérico embaralhado.
  static String generateOnlyNumbersUUID() {
    int generateRandom() => Random().nextInt(9000) + 1000;

    String uuid =
        '${generateRandom()}${DateFormat('MMHHssyyyymmddSS').format(DateTime.now())}';
    List<String> chars = uuid.split('')..shuffle();
    String shuffled = chars.join('');
    return RegExp(
      r'.{1,4}',
    ).allMatches(shuffled).map((m) => m.group(0)!).join('-');
  }

  /// Preenche uma string até um tamanho específico com um caractere.
  static String fillChar(String input, int totalDigits, String char) {
    return input.padLeft(totalDigits, char);
  }

  /// Formata um número com casas decimais.
  static double formatFloat(num? value, [int decimalPlaces = 2]) {
    double val = valueOrDefault(value?.toDouble(), 0);
    return double.parse(val.toStringAsFixed(decimalPlaces));
  }

  /// Gera uma chave baseada na data/hora atual.
  static String generateKey() {
    return DateFormat('yyyyMMddHHmmssSSS').format(DateTime.now());
  }

  /// Retorna o texto em maiúsculas, garantindo que não seja nulo.
  static String safeUpperCase(String? text) {
    return valueOrDefault(text, '').toUpperCase();
  }

  /// Verifica se a string contém todos os dígitos iguais.
  static bool isSameDigits(String input) {
    return RegExp(r'^(\d)\1*$').hasMatch(input);
  }

  /// Retorna o valor de uma propriedade de um mapa ou o valor padrão.
  static dynamic hasOwnPropertyOrDefault(
    Map<String, dynamic>? own,
    String field,
    dynamic defaultValue,
  ) {
    if (own != null && own.containsKey(field)) {
      return own[field];
    }
    return defaultValue;
  }

  /// Retorna uma substring segura.
  static String safeString(String? field, int substringLength) {
    return field != null && field.isNotEmpty
        ? field.substring(0, substringLength.clamp(0, field.length))
        : '';
  }
}
