import 'dart:math';

class MathHelper {
  static const int maxDecimalPlaces = 15;

  static double calculateRoundAbnt(num qty, num value, int decimalPlaces) {
    double totalValue = double.parse(
      (qty * value).toStringAsFixed(maxDecimalPlaces),
    );
    double calculatedValue = roundAbnt(totalValue, decimalPlaces);
    return double.parse(calculatedValue.toString());
  }

  static double roundAbnt(num value, int decimalPlaces) {
    double calculatedValue = value.toDouble();
    List<String> splitedValue = calculatedValue.toString().split('.');
    String decimalValue = splitedValue.length > 1 ? splitedValue[1] : '';
    int subsequentNumber = decimalPlaces;

    if (decimalPlaces < 1) {
      return calculatedValue.truncateToDouble();
    }

    if (decimalValue.length <= decimalPlaces) {
      return calculatedValue;
    }

    String substr = decimalValue.substring(
      subsequentNumber,
      subsequentNumber + 1,
    );
    if (substr != '5') {
      return double.parse(calculatedValue.toStringAsFixed(decimalPlaces));
    }

    String substr1 = decimalValue.substring(
      subsequentNumber,
      subsequentNumber + 1,
    );
    if (substr1 == '5') {
      String substr2 = decimalValue.substring(
        subsequentNumber - 1,
        subsequentNumber,
      );
      if (int.parse(substr2) % 2 != 0) {
        return round(calculatedValue, decimalPlaces);
      }

      String substr3 = decimalValue.substring(
        subsequentNumber + 1,
        subsequentNumber + 2,
      );
      if (int.parse(substr3) > 0) {
        return double.parse(calculatedValue.toStringAsFixed(decimalPlaces));
      }

      return truncate(value, decimalPlaces);
    }

    return calculatedValue;
  }

  static double truncate(num value, int decimalsQty) {
    double calculatedValue = value.toDouble();
    List<String> splitedValue = value.toString().split('.');
    String decimalPlaces = splitedValue.length > 1 ? splitedValue[1] : '';

    if (decimalsQty < 1) {
      return calculatedValue.truncateToDouble();
    }

    if (decimalPlaces.length <= decimalsQty) {
      return calculatedValue;
    }

    String truncatedStr =
        '${splitedValue[0]}.${decimalPlaces.substring(0, decimalsQty)}';
    calculatedValue = double.parse(truncatedStr);

    return calculatedValue;
  }

  static double round(num value, int decimalsQty) {
    String valStr = value.toString();
    if (!valStr.contains('e')) {
      return double.parse((value * pow(10, decimalsQty)).round().toString()) /
          pow(10, decimalsQty);
    } else {
      List<String> splitedValue = valStr.split('e');
      int exponent = int.parse(splitedValue[1]);

      double rounded =
          double.parse(
            (double.parse(splitedValue[0]) * pow(10, exponent + decimalsQty))
                .round()
                .toString(),
          ) /
          pow(10, decimalsQty);
      return rounded;
    }
  }
}
