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

class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
