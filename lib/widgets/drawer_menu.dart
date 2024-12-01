import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri policyUrl = Uri.parse('https://www.notion.so/14f257a1bbb180aa8d38c47502408f64?pvs=4');
final Uri ruleUrl = Uri.parse('https://www.notion.so/14f257a1bbb18009a70bd4f1e5ae6234?pvs=4');
final Uri helpUrl = Uri.parse('https://celestial-clam-8a3.notion.site/AIChats-4294b075a76341d8955ec3374aa5f8db');


class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // アプリロゴ
                Icon(
                  Icons.chat_bubble_outline,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 40,
                ),

                const SizedBox(height: 4),

                // アプリ名
                Text(
                  'Demo ChatGPT',
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),

                const SizedBox(height: 4),

                // Information
                Text(
                  'Text ChatGPT',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSecondary.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          // アプリShare
          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: const Text('アプリをシェアしよう'),
            onTap: () {
              Navigator.pop(context);
              _shareApp();
            },
          ),
          // プライバシーポリシー
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('プライバシーポリシー'),
            onTap: () {
              _launchPolicyUrl();
            },
          ),
          // 利用規約のリストタイル
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text('利用規約'),
            onTap: _launchRuleUrl,
          ),
          const Divider(),
          // ヘルプ＆サポートのリストタイル
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text('ヘルプ＆サポート'),
            onTap: _launchHelpUrl,
          ),
        ],
      ),
    );
  }

  void _shareApp() async {
    await Share.share(
      'AIChatsで最先端のAIとチャットしよう！日常のタスクや質問をサポートします。人工知能の力で快適な日々を過ごしましょう！ https://onl.bz/3tQXG7k',
    );
  }

  Future<void> _launchPolicyUrl() async {
    if (!await launchUrl(policyUrl)) {
      throw Exception('無効なURLです。');
    }
  }

  // 利用規約のURLを開くための関数
  Future<void> _launchRuleUrl() async {
    if (!await launchUrl(ruleUrl)) {
      throw Exception('無効なURLです。');
    }
  }

  // ヘルプ＆サポートのURLを開くための関数
  Future<void> _launchHelpUrl() async {
    if (!await launchUrl(helpUrl)) {
      throw Exception('無効なURLです。');
    }
  }
}
