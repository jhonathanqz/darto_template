import 'string_helper.dart'; // Import da sua StringHelper se necessário

class PhoneHelper {
  /// Formata um número de telefone no padrão (XX) XXXX-XXXX ou (XX) XXXXX-XXXX
  static String formatPhoneNumber(String phoneNumber) {
    final cleanedNumber = StringHelper.onlyNumbers(phoneNumber);

    // Limita a 11 caracteres
    final str = cleanedNumber.length > 11
        ? cleanedNumber.substring(0, 11)
        : cleanedNumber;

    final regex = RegExp(r'^([0-9]{2})([0-9]{4,5})([0-9]{4})$');

    final match = regex.firstMatch(str);
    if (match != null) {
      return '(${match[1]}) ${match[2]}-${match[3]}';
    }

    return str; // Retorna como está se não casar com o regex
  }
}
