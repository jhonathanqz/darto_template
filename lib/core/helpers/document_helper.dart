class DocumentHelper {
  /// Remove todos os caracteres que não sejam números
  static String _onlyNumbers(String input) {
    return input.replaceAll(RegExp(r'[^0-9]'), '');
  }

  /// Verifica se o documento é válido (CPF ou CNPJ)
  static bool isValid(String document) {
    final number = _onlyNumbers(document);

    if (number.length != 11 && number.length != 14) {
      return false;
    }

    if (number.length == 11) {
      return _checkCPF(number);
    }

    return _checkCNPJ(number);
  }

  /// Verifica se é um CPF válido
  static bool _checkCPF(String document) {
    if (RegExp(r'^(\d)\1*$').hasMatch(document)) {
      return false;
    }

    final sum = List.generate(
      9,
      (i) => int.parse(document[i]) * (10 - i),
    ).reduce((a, b) => a + b);

    var remainder = (sum * 10) % 11;
    if (remainder == 10 || remainder == 11) {
      remainder = 0;
    }
    if (remainder != int.parse(document[9])) {
      return false;
    }

    final sum2 = List.generate(
      10,
      (i) => int.parse(document[i]) * (11 - i),
    ).reduce((a, b) => a + b);

    var remainder2 = (sum2 * 10) % 11;
    if (remainder2 == 10 || remainder2 == 11) {
      remainder2 = 0;
    }
    if (remainder2 != int.parse(document[10])) {
      return false;
    }

    return true;
  }

  /// Verifica se é um CNPJ válido
  static bool _checkCNPJ(String document) {
    if (RegExp(r'^(\d)\1*$').hasMatch(document)) {
      return false;
    }

    final sum = List.generate(12, (i) {
      final weight = i < 4 ? 5 - i : 13 - i;
      return int.parse(document[i]) * weight;
    }).reduce((a, b) => a + b);

    var remainder = sum % 11;
    if ((remainder == 0 || remainder == 1) && int.parse(document[12]) != 0) {
      return false;
    } else if (remainder > 1 && int.parse(document[12]) != 11 - remainder) {
      return false;
    }

    final sum2 = List.generate(13, (i) {
      final weight = i < 5 ? 6 - i : 14 - i;
      return int.parse(document[i]) * weight;
    }).reduce((a, b) => a + b);

    var remainder2 = sum2 % 11;
    if ((remainder2 == 0 || remainder2 == 1) && int.parse(document[13]) != 0) {
      return false;
    } else if (remainder2 > 1 && int.parse(document[13]) != 11 - remainder2) {
      return false;
    }

    return true;
  }

  /// Retorna true se for CPF
  static bool isCPF(String document) {
    final number = _onlyNumbers(document);
    return number.length == 11;
  }

  /// Retorna true se for CNPJ
  static bool isCNPJ(String document) {
    final number = _onlyNumbers(document);
    return number.length == 14;
  }
}
