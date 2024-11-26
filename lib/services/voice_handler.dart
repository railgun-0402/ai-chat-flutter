import 'dart:async';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceHandler {
  final SpeechToText _speechToText = SpeechToText();
  // 音声認識利用可能フラグ
  bool _speechEnabled = false;

  void initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
  }

  // 音声認識を開始し、認識結果を返却する
  Future<String> startListening() async {
    final completer = Completer<String>();
    _speechToText.listen(
      onResult: (result) {
        if (result.finalResult) {
          completer.complete(result.recognizedWords);
        }
      },
      localeId: 'ja_JP',
    );
    return completer.future;
  }

  Future<void> stopListening() async {
    await _speechToText.stop();
  }

  SpeechToText get speechToText => _speechToText;
  bool get isEnabled => _speechEnabled;
}