import 'package:flutter_riverpod/flutter_riverpod.dart';

/// アプリの現テーマを保持するStateProvider
final activeThemeProvider = StateProvider<Themes>(
    (ref) => Themes.dark,
);

// Themeのenum
enum Themes {
  dark,
  light,
}
