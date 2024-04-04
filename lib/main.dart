import 'package:flutter/material.dart';
// import simple animations
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app1/services/db_services.dart';

import 'app_routes.dart';
import 'features/settings/themes/provider/theme_provider.dart';
import 'utils/constants.dart';

Future<void> main() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await Hive.openBox(Constants.settingsStorageKey); // settings
  await Hive.openBox(Constants.authStorageKey); // auth
  

  // api getters
  // now hide splash screen
  FlutterNativeSplash.remove();

  // dependency waiting
  final container = ProviderContainer();
  await container.read(dbServiceProvider.future);

  runApp( UncontrolledProviderScope(
    container: container,
    child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Leetcode Tracker',
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: appRoutes,
      theme: FlexThemeData.light(scheme: theme.scheme).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      darkTheme: FlexThemeData.dark(scheme: theme.scheme).copyWith(
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
      ),
      themeMode: theme.mode,
    );
  }
}