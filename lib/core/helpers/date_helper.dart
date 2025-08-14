import 'package:intl/intl.dart';
// import 'package:jiffy/jiffy.dart';

class DateHelper {
  static const List<String> momentValidateAllowedTypes = [
    'dd/MM/yyyy',
    'yyyy-MM-dd',
    'dd/MM/yyyy HH:mm:ss.SSS',
    'yyyy-MM-dd HH:mm:ss.SSS',
    "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
    'yyyy-MM-dd HH:mm:ss.SSSZ',
  ];

  static const List<String> daysOfWeekPtBr = [
    'domingo',
    'segunda',
    'terca',
    'quarta',
    'quinta',
    'sexta',
    'sabado',
  ];

  static const List<String> daysOfWeekEnUs = [
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
    'friday',
    'saturday',
  ];

  /// Converte timestamp (em segundos) para DateTime
  static DateTime convertTimestampToDate(int timestampInSeconds) {
    return DateTime.fromMillisecondsSinceEpoch(timestampInSeconds * 1000);
  }

  static String formatDateTimePtBr(DateTime date) {
    return date.millisecondsSinceEpoch > 0
        ? DateFormat('dd/MM/yyyy HH:mm:ss').format(date.toLocal())
        : '';
  }

  static String formatDateMonthDayYear(DateTime date) {
    return date.millisecondsSinceEpoch > 0
        ? DateFormat('MM/dd/yyyy').format(date.toLocal())
        : '';
  }

  static String formatDateTimeEnUsWithoutTime(DateTime date) {
    return date.millisecondsSinceEpoch > 0
        ? DateFormat('yyyy-MM-dd 00:00:00').format(date)
        : '';
  }

  static String formatDateTimeEnUs(DateTime date) {
    return date.millisecondsSinceEpoch > 0
        ? DateFormat('yyyy-MM-dd HH:mm:ss').format(date)
        : '';
  }

  static String formatDateEnUs(DateTime date) {
    return date.millisecondsSinceEpoch > 0
        ? DateFormat('yyyy-MM-dd').format(date)
        : '';
  }

  static String dayOfWeekPtBr(DateTime date) {
    return daysOfWeekPtBr[date.weekday % 7];
  }

  static String formatTime(DateTime date) {
    return date.millisecondsSinceEpoch > 0
        ? DateFormat('HH:mm').format(date)
        : '';
  }

  static List<String> buildTimeLineArray() {
    final List<String> arr = [];
    final String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (int i = 0; i < 24; i++) {
      for (int j = 0; j < 12; j++) {
        final String hour = i.toString().padLeft(2, '0');
        final String minute = (j == 0 ? 0 : 5 * j).toString().padLeft(2, '0');
        arr.add('$today $hour:$minute:00');
      }
    }
    return arr;
  }

  static String dayOfWeekEnUs(DateTime date) {
    return daysOfWeekEnUs[date.weekday % 7];
  }

  static bool checkDate(String dateString) {
    try {
      for (final pattern in momentValidateAllowedTypes) {
        try {
          final parsed = DateFormat(pattern).tryParseStrict(dateString);
          if (parsed != null) return true;
        } catch (_) {}
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  static String parseDatePtBrToEnUSUTC(String dateString) {
    for (final pattern in momentValidateAllowedTypes) {
      try {
        final parsed = DateFormat(pattern).parse(dateString);
        return DateFormat('yyyy-MM-dd').format(parsed);
      } catch (_) {}
    }
    return '';
  }

  static String parseDateToPtBrUTC(String dateString) {
    for (final pattern in momentValidateAllowedTypes) {
      try {
        final parsed = DateFormat(pattern).parse(dateString);
        return DateFormat('dd/MM/yyyy').format(parsed);
      } catch (_) {}
    }
    return '';
  }

  static int formatTimestampUTCBr(DateTime date) {
    return date.subtract(const Duration(hours: 3)).millisecondsSinceEpoch;
  }

  static String buildPeriodFromDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inSeconds.abs();

    if (difference < 60) {
      return '$difference ${difference == 1 ? 'segundo' : 'segundos'}';
    }

    final months = difference ~/ (30 * 24 * 3600);
    final days = (difference ~/ (24 * 3600)) % 30;
    final hours = (difference ~/ 3600) % 24;
    final minutes = (difference ~/ 60) % 60;
    final seconds = difference % 60;

    final List<String> parts = [];

    if (months > 0) parts.add('$months ${months == 1 ? 'mês' : 'meses'}');
    if (days > 0) parts.add('$days ${days == 1 ? 'dia' : 'dias'}');
    if (hours > 0) parts.add('$hours ${hours == 1 ? 'hora' : 'horas'}');
    if (minutes > 0) {
      parts.add('$minutes ${minutes == 1 ? 'minuto' : 'minutos'}');
    }
    if (seconds > 0) {
      parts.add('$seconds ${seconds == 1 ? 'segundo' : 'segundos'}');
    }

    return parts.join(' ');
  }
}
