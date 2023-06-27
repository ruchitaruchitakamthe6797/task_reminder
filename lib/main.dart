import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:send_remider_to_user/ui/contacts/contacts.dart';
import 'package:send_remider_to_user/ui/my_app.dart';

import 'di/components/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setPreferredOrientations();
  await setupLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(RelationshipAdapter());
  await Hive.openBox<Contact>(contactsBoxName);
  // runApp(MyApp1());
  return runZonedGuarded(() async {
    runApp(MyApp());
  }, (error, stack) {
    print(stack);
    print(error);
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(ContactAdapter());
//   Hive.registerAdapter(RelationshipAdapter());
//   await Hive.openBox<Contact>(contactsBoxName);
//   runApp(MyApp1());
// }
