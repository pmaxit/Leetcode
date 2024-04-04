import 'package:flutter/material.dart';
import 'package:test_app1/features/settings/ui/settings_screen.dart';

import 'features/home/ui/home.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  SettingsScreen.route: (context) => const SettingsScreen(),
  HomeScreen.route: (context) => const HomeScreen(),
};


// Route<dynamic>? appGeneratedRoutes(RouteSettings settings) {
//   switch (settings.name) {
//     case CounterScreen.route:
//       return PageTransition(
//           child: const CounterScreen(), type: PageTransitionType.bottomToTop);
//     case TimerScreen.route:
//       return PageTransition(
//           child: const TimerScreen(), type: PageTransitionType.bottomToTop);
//     default:
//       break;
//   }

//   return null;
// }