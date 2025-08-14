import 'dart:io';

import 'package:darto/darto.dart';
import 'package:path/path.dart';
import 'package:swagger_ui_darto/swagger_ui_darto.dart';

class SwaggerApi {
  // Swagger UI options configuration is optional 🌟
  final _options = SwaggerUiOptions(
    title: 'Darto Template - APi',
    deepLink: true,
    syntaxHighlightTheme: 'monokai',
    persistAuthorization: true,
  );

  // Define the absolute path to the swagger.json file
  final _swaggerJsonPath = join(Directory.current.path, 'swagger.json');

  Router get swaggerConfig {
    return SwaggerUi.serve(_swaggerJsonPath, options: _options);
  }
}
