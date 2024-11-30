import 'package:ai_chat/widgets/text_and_voice_field.dart';
import 'package:flutter/material.dart';

class ToggleButton extends StatefulWidget {
  final VoidCallback _sendTextMessage;
  final VoidCallback _sendVoiceMessage;
  final InputMode _inputMode;
  final bool _isReplying;
  final bool _isListening;

  const ToggleButton({
    Key? key,
    required InputMode inputMode,
    required VoidCallback sendTextMessage,
    required VoidCallback sendVoiceMessage,
    required bool isReplying,
    required bool isListening,
  }) : _inputMode = inputMode,
       _sendTextMessage = sendTextMessage,
       _sendVoiceMessage = sendVoiceMessage,
       _isReplying = isReplying,
       _isListening = isListening,
       super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton>
 with SingleTickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.onSecondary;
    final padding = MediaQuery.of(context).size.width * 0.025;

    return Stack(
      alignment: Alignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            foregroundColor: widget._isReplying ? Colors.grey : iconColor,
            shape: const CircleBorder(),
            padding: EdgeInsets.all(padding),
          ),
          // 返信中はボタン無効化
          onPressed: widget._isReplying
            ? null
            : (widget._inputMode == InputMode.text
                ? widget._sendTextMessage
                : () {
                    widget._sendVoiceMessage();
                  }),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                if (widget._isListening)
                  BoxShadow(
                    color: Colors.redAccent.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
              ],
            ),
            child: Icon(
              // テキストモードか音声モードかでアイコンを切り替える
              widget._inputMode == InputMode.text
                  ? Icons.send
                  : widget._isListening
                    ? Icons.mic_off
                    : Icons.mic,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
