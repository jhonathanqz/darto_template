import 'package:darto/darto.dart';
import 'package:get_it/get_it.dart';

final inject = GetIt.instance;

abstract class ApiModule {
  // Método público que já fornece o GetIt pronto
  void configureRoutes(Router router) => onConfigureRoutes(router, inject);

  // Método público que já fornece o GetIt pronto
  void binds() => onBinds(inject);

  // Subclasses implementam esses dois
  void onConfigureRoutes(Router router, GetIt i);
  void onBinds(GetIt i);

  void init(Router router) {
    binds();
    configureRoutes(router);
  }
}
