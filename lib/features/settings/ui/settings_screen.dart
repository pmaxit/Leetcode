import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../themes/provider/theme_provider.dart';


class SettingsScreen extends ConsumerWidget{
  const SettingsScreen({super.key});
  static const route = '/settings';

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final theme = ref.watch(themeProvider);
    final schemes = ref.watch(schemesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: theme.isDarkMode,
              onChanged: (value){
                ref.read(themeProvider.notifier).toggle();
              },
            ),
          ),
          ListTile(
            title: const Text('Theme'),
            trailing: DropdownButton<FlexScheme>(
              value: theme.scheme,
              onChanged: (value){
                ref.read(themeProvider.notifier).setScheme(value!);
              },
              items: schemes.map((e) => DropdownMenuItem(
                value: e.scheme,
                child: Text(e.name),
              )).toList(),
            ),
          ),
        ],
      ),
    );
  }
}