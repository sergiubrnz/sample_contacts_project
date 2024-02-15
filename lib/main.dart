import 'package:contact_app/ui/screens/contact_list_screen/contact_list_view.dart';
import 'package:contact_app/utils/locator/locator.dart';
import 'package:contact_app/utils/models/contact_adapter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'ui/screens/contact_details_screen/contact_details_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox('contacts');

  setupLocator();

  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const ContactsListScreenView();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            final contactId = state.extra as String?;
            return ContactDetailsView(contactId: contactId);
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData.dark(),
      title: 'Contacts',
    );
  }
}
