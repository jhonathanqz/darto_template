import 'package:darto/darto.dart';
import 'package:get_it/get_it.dart';
import 'package:darto_template/core/interface/api_module.dart';
import 'package:darto_template/modules/health_check/health_controller.dart';

class HealthModule extends ApiModule {
  @override
  void onBinds(GetIt i) {
    i.registerFactory(() => HealthController());
  }

  @override
  void onConfigureRoutes(Router router, GetIt i) {
    final HealthController controller = i.get();

    router.get('/', controller.healthCheck);
  }
}
