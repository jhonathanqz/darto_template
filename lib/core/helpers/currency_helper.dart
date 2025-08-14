import 'package:intl/intl.dart';
import 'string_helper.dart';

class CurrencyHelper {
  static final NumberFormat _currencyFormatBRL = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
  );
  static final NumberFormat _floatFormatBRL = NumberFormat.decimalPattern(
    'pt_BR',
  );
  static final NumberFormat _percentFormat = NumberFormat.decimalPercentPattern(
    locale: 'pt_BR',
    decimalDigits: 2,
  );

  /// Formata valor para moeda brasileira (R$ 1.234,56)
  static String formatCurrencyBRL(num? value) {
    final safeValue = StringHelper.valueOrDefault(value, 0);
    return _currencyFormatBRL.format(safeValue);
  }

  /// Formata número no padrão brasileiro sem símbolo de moeda
  static String formatFloatBRL(num? value) {
    final safeValue = StringHelper.valueOrDefault(value, 0);
    return _floatFormatBRL.format(safeValue);
  }

  /// Formata percentual (0.25 → 25,00%)
  static String formatPercent(num? value) {
    final safeValue = StringHelper.valueOrDefault(value, 0);
    return _percentFormat.format(safeValue / 100);
  }
}
