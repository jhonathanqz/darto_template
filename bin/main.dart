import 'package:darto/darto.dart';
import 'package:darto_template/config/databases/database.dart';
import 'package:darto_template/config/docs/swagger_api.dart';
import 'package:darto_template/core/interface/api_module.dart';
import 'package:darto_template/modules/health_check/health_module.dart';
import 'package:darto_template/modules/user/user_module.dart';

void main() async {
  final app = Darto();
  await _initialize();

  app.use('/docs', SwaggerApi().swaggerConfig);
  app.use('/health-check', HealthModule().init);
  app.use('/user', UserModule().init);

  app.timeout(30000);

  app.listen(3000, () {
    print('Server is running on port 3000');
  });
}

Future<void> _initialize() async {
  try {
    final database = Database();
    await database.db;

    inject.registerSingleton<Database>(database);
  } catch (e) {
    print('Error initializing database: $e');
  }
}
