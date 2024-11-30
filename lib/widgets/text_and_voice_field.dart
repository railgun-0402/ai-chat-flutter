import 'package:ai_chat/models/chat_model.dart';
import 'package:ai_chat/providers/chats_provider.dart';
import 'package:ai_chat/services/ai_handler.dart';
import 'package:ai_chat/services/voice_handler.dart';
import 'package:ai_chat/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

/*
 * テキスト or 音声モード
 */
enum InputMode {
  text,
  voice,
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField>
  with TickerProviderStateMixin {

  // 入力モードを示すenum
  InputMode _inputMode = InputMode.voice;
  // メッセージ入力用
  final _messageController = TextEditingController();

  final AIHandler _openAI = AIHandler();
  final VoiceHandler voiceHandler = VoiceHandler();

  var _isReplying = false;  // 返信状態
  var _isListening = false; // リスニング状態

  late AnimationController _typingAnimationController;
  late Animation<double> _typingAnimation;

  @override
  void initState() {
    voiceHandler.initSpeech();

    // 入力中のアニメーション設定
    _typingAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);
    _typingAnimation =
        Tween<double>(begin: 0, end: 1).animate(_typingAnimationController);
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _typingAnimationController.dispose();
    _openAI.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 4,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              // TextField
              Expanded(
                child: TextField(
                  minLines: 1,
                  maxLines: 4,
                  controller: _messageController,
                  onChanged: (value) {
                    value.isNotEmpty
                        ? setInputMode(InputMode.text)
                        : setInputMode(InputMode.voice);
                  },
                  cursorColor: Theme.of(context).colorScheme.onPrimary,
                  decoration: InputDecoration(
                    hintText: 'メッセージを入力...',
                    hintStyle: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.7),
                    ),
                    border: InputBorder.none,
                    contentPadding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
            ],
          ),
        ),

        // Toggle
        Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.08,
              child: ToggleButton(
                isListening: _isListening,
                isReplying: _isReplying,
                inputMode: _inputMode,
                sendTextMessage: () {
                  final message = _messageController.text;
                  _messageController.clear();
                  sendTextMessage(message);
                },
                sendVoiceMessage: sendVoiceMessage,
              ),
            ),
        ),
      ],
    );
  }

  // 入力モードを更新
  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  // 音声メッセージを送信
  void sendVoiceMessage() async {
    if (!voiceHandler.isEnabled) {
      return;
    }

    if (voiceHandler.speechToText.isListening) {
      await voiceHandler.stopListening();
      setListeningState(false);
    } else {
      setListeningState(true);
      final result = await voiceHandler.startListening();
      setListeningState(false);
      sendTextMessage(result);
    }
  }

  // テキストメッセージを送信
  void sendTextMessage(String message) async {
    setReplyingState(true);
    addToChatList(message, true, DateTime.now().toString());
    addToChatList('...', false, 'typing');
    setInputMode(InputMode.voice);

    final aiResponse = await _openAI.getResponse(message);
    removeTyping();
    addToChatList(aiResponse, false, DateTime.now().toString());
    setReplyingState(false);
  }

  // 返信状態更新
  void setReplyingState(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  // リスニング状態を更新
  void setListeningState(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
  }

  // チャットリストから入力中のアイテムを削除
  void removeTyping() {
    final chats = ref.read(chatsProvider.notifier);
    chats.removeTyping();
  }

  // チャットリストにアイテム追加
  void addToChatList(String message, bool isMe, String id) {
    final chats = ref.read(chatsProvider.notifier);
    chats.add(ChatModel(
      id: id,
      message: message,
      isMe: isMe,
      typingAnimation: _typingAnimation,
    ));
  }

}
