import 'package:chat_gpt_sdk/chat_gpt_sdk.dart'; // ChatGPTSDK をインポート

class AIHandler {
  // OpenAIインスタンスを作成し、APIキーを設定します。
  final _openAI = OpenAI.instance.build(
    token: '',
    baseOption: HttpSetup(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
    ),
  );

  // メッセージ履歴を保存するためのリストです。
  final List<Map<String, String>> _messageHistory = [];

  // ユーザーからのメッセージを受け取り、AIからの応答を返すメソッドです。
  Future<String> getResponse(String message) async {
    try {
      // システムメッセージとして、AIアシスタントの役割を追加します。
      _messageHistory.add({
        "role": "system",
        "content":
        "Flutterでテキストに色をつける方法を簡単に教えて",
      });
      // ユーザーからのメッセージを追加します。
      _messageHistory.add({
        "role": "user",
        "content": message,
      });

      // ChatCompleteTextリクエストを作成します。
      final request = ChatCompleteText(
        messages: _messageHistory,
        temperature: 0.5,
        topP: 0.9,
        presencePenalty: 0.2,
        maxToken: 400,
        model: GptTurboChatModel(),
      );

      // リクエストを送信し、レスポンスを受け取ります。
      final response = await _openAI.onChatCompletion(request: request);
      if (response != null) {
        // AIアシスタントの応答を取得し、メッセージ履歴に追加します。
        String assistantResponse =
            response.choices[0].message?.content.trim() ?? '';
        _messageHistory
            .add({"role": "assistant", "content": assistantResponse});
        return assistantResponse;
      }
      return '問題が発生しました。しばらくしてから再度お試しください。';
    } catch (e) {
      return '問題が発生しました。しばらくしてから再度お試しください。';
    }
  }

  // リソースを解放するためのメソッドです。
  void dispose() {
    _messageHistory.clear();
  }
}