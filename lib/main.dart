import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app_router.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Future.wait([
    Hive.openBox<Map>(AppConstants.offlineQueueBox),
    Hive.openBox<Map>(AppConstants.customersBox),
    Hive.openBox<Map>(AppConstants.vouchersBox),
  ]);

  runApp(const ProviderScope(child: NineApp()));
}

class NineApp extends StatelessWidget {
  const NineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
