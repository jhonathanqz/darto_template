import 'dart:convert';
import 'dart:io';

import 'package:darto/darto.dart';

class MessageHelper {
  /// Lida com erros, buscando a mensagem pelo `key` e substituindo parâmetros.
  static Future<String> errorHandler(
    String key,
    List<Map<String, String>> params,
    DartoHeader headers,
  ) async {
    final path = _checkPath(headers);

    final file = File(path);
    if (!file.existsSync()) {
      return 'Uncataloged error';
    }

    final messages =
        jsonDecode(await file.readAsString()) as Map<String, dynamic>;

    final message = messages[key];
    if (message != null) {
      return _buildMessage(message, params);
    }

    return 'Uncataloged error';
  }

  /// Monta a mensagem com substituição de parâmetros.
  static String _buildMessage(
    String message,
    List<Map<String, String>> params,
  ) {
    return _replaceMessageParams(message, params);
  }

  /// Substitui placeholders no formato [:param] pelos valores fornecidos.
  static String _replaceMessageParams(
    String message,
    List<Map<String, String>> params,
  ) {
    if (params.isEmpty) return message;
    for (var map in params) {
      map.forEach((key, value) {
        message = message.replaceAll(key, value);
      });
    }
    return message;
  }

  /// Verifica o path do arquivo de tradução com base no header `x-lang`.
  static String _checkPath(DartoHeader headers) {
    String? language = headers.get('x-lang') ?? 'pt-br';

    final path = 'lib/translations/$language.json';

    if (File(path).existsSync()) {
      return path;
    }
    return 'lib/translations/pt-br.json';
  }
}
