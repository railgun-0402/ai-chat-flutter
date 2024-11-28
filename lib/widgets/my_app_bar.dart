import 'package:ai_chat/providers/active_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MyAppBar({required this.scaffoldKey, super.key});

  @override
  ConsumerState createState() => _MyAppBarState();

  // preferredSizeプロパティで、サイズの定義が可能
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends ConsumerState<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        // タップでDrawer画面へ
        onPressed: () => widget.scaffoldKey.currentState?.openDrawer(),
      ),
      title: Text(
        'Demo ChatGPT',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      // titleは中央
      centerTitle: true,

      // 右側のボタン
      actions: [
        IconButton(
          icon: Icon(
            ref.watch(activeThemeProvider) == Themes.dark
                ? Icons.brightness_4
                : Icons.brightness_7,
          ),
          // ダークモードとの切り替え
          onPressed: () async {
            Themes newTheme = ref.read(activeThemeProvider) == Themes.dark
                ? Themes.light
                : Themes.dark;
            ref.read(activeThemeProvider.notifier).state = newTheme;
          },
        ),
      ],
    );
  }
}
