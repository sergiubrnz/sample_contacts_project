import 'package:contact_app/utils/services/contact_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => ContactsService());
}
