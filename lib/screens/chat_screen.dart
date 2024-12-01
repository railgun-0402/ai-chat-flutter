import 'package:ai_chat/providers/chats_provider.dart';
import 'package:ai_chat/widgets/chat_item.dart';
import 'package:ai_chat/widgets/drawer_menu.dart';
import 'package:ai_chat/widgets/my_app_bar.dart';
import 'package:ai_chat/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/*
 * チャット画面を表示するウィジェット
 */
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: GestureDetector(
        onTap: _focusNode.requestFocus,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: MyAppBar(scaffoldKey: _scaffoldKey),
          drawer: const DrawerMenu(),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    // チャットリスト表示
                    child: Consumer(builder: (context, ref, child) {
                      final chats = ref.watch(chatsProvider).reversed.toList();
                      return chats.isNotEmpty
                          ? ListView.builder(
                        reverse: true,
                        itemCount: chats.length,
                        itemBuilder: (context, index) => ChatItem(
                          message: chats[index].message,
                          isMe: chats[index].isMe,
                          typingAnimation: chats[index].typingAnimation,
                        ),
                      )
                          : _buildEmptyMessageUI(context);
                    }),
                  ),
                  // TextAndVoiceField
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child:
                    TextAndVoiceField(),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // メッセージが空の場合
  Widget _buildEmptyMessageUI(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.android,
          color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
          size: 80,
        ),
        Text(
          "チャットを始めよう",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.4),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}