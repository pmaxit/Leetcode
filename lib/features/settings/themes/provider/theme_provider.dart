import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../data/theme_scheme.dart';
import '../data/theme_state.dart';


final themeProvider = StateNotifierProvider<ThemeStateNotifier, ThemeState>((ref){
  final box = Hive.box('settings');
  final isDarkMode = box.get('isDarkMode', defaultValue: false) as bool;
  return ThemeStateNotifier(ThemeState(
    mode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    scheme: FlexScheme.material,
    isDarkMode: isDarkMode,
  ));
});

class ThemeStateNotifier extends StateNotifier<ThemeState>{
  ThemeStateNotifier(super.state);


  void toggle(){
    state = state.copyWith(isDarkMode: !state.isDarkMode,
          mode: state.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
  void setThemeMode(ThemeMode mode){
    state = state.copyWith(mode: mode);
  }

  void setScheme(FlexScheme scheme){
    state = state.copyWith(scheme: scheme);
  }

  void setDarkMode(bool isDarkMode){
    state = state.copyWith(isDarkMode: isDarkMode);
  }

  void updateStorage([bool isDarkMode = false]){
    final box = Hive.box('settings');
    box.put('isDarkMode', isDarkMode);
  }
}

final schemesProvider = StateProvider<List<ThemeScheme>>((ref)=> [
   const ThemeScheme(
        name: 'Deep Purple',
        scheme: FlexScheme.deepPurple,
        color: Color(0xff4A2EA3),
      ),
      const ThemeScheme(
        name: 'Aqua Blue',
        scheme: FlexScheme.aquaBlue,
        color: Color(0xff3BA3CD),
      ),
      const ThemeScheme(
        name: 'Amber',
        scheme: FlexScheme.amber,
        color: Color(0xffE65706),
      ),
      const ThemeScheme(
        name: 'Big Stone',
        scheme: FlexScheme.bigStone,
        color: Color(0xff223348),
      ),
      const ThemeScheme(
        name: 'Mallard',
        scheme: FlexScheme.mallardGreen,
        color: Color(0xff344A27),
      ),
      const ThemeScheme(
        name: 'Wasabi',
        scheme: FlexScheme.wasabi,
        color: Color(0xff77892B),
      ),
      const ThemeScheme(
        name: 'Red Wine',
        scheme: FlexScheme.redWine,
        color: Color(0xff9E2237),
      ),
      const ThemeScheme(
        name: 'Material',
        scheme: FlexScheme.material,
        color: Color(0xff6709EF),
      ),
]);