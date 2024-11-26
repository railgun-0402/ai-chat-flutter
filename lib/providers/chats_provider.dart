
import 'package:ai_chat/models/chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatNotifier extends StateNotifier<List<ChatModel>> {
  ChatNotifier() : super([]);

  // 新しいChatModelを状態追加
  void add(ChatModel chatModel) {
    state = [...state, chatModel];
  }

  // id == typingのChatModelを削除
  void removeTyping() {
    state = state..removeWhere((chat) => chat.id == 'typing');
  }
}

final chatsProvider = StateNotifierProvider<ChatNotifier, List<ChatModel>>(
    (ref) => ChatNotifier(),
);
