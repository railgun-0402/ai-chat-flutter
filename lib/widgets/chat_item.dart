import 'dart:ffi';

import 'package:flutter/material.dart';

class ChatItem extends StatefulWidget {
  // メッセージの内容です。
  final String message;
  // 自分が送信したメッセージかどうかです。
  final bool isMe;
  // 入力中のアニメーションです。
  final Animation<double> typingAnimation;

  const ChatItem({
    super.key,
    required this.message,
    required this.isMe,
    required this.typingAnimation,
  });

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {

  // 入力中のドットアニメーションを作成
  Widget _buildColoredDot(int index, Animation<double> animation) {
    double animationValue = (animation.value * 3) - index;
    if (animationValue < 0) animationValue = 0;
    if (animationValue > 1) animationValue = 1;
    return Icon(
      Icons.circle,
      size: 10,
      color: Color.lerp(
          Theme.of(context).colorScheme.onSecondary,
          Colors.grey.shade600,
          animationValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
        widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          // Icon
          if (!widget.isMe) ProfileContainer(isMe: widget.isMe),
          if (!widget.isMe) const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
            ),
            decoration: BoxDecoration(
              color: widget.isMe
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(12),
            ),
            child: widget.message == '...'
            ? SizedBox(
              width: 48,
              height: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  return AnimatedBuilder(
                      animation: widget.typingAnimation,
                      builder: (context, child) {
                        return _buildColoredDot(
                            index,
                            widget.typingAnimation,
                        );
                      },
                  );
                }),
              ),
            ) : SelectableText(
              widget.message,
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
          if (widget.isMe) const SizedBox(width: 12),
          if (widget.isMe) ProfileContainer(isMe: widget.isMe),
        ],
      ),
    );
  }
}

class ProfileContainer extends StatelessWidget {
  final bool isMe;
  const ProfileContainer({
    Key? key,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isMe
            ? Theme.of(context).colorScheme.secondary
            : Colors.grey.shade800,
        borderRadius: BorderRadius.circular(20),
      ),
      child: isMe
      ? Icon(
        Icons.face,
        color: Theme.of(context).colorScheme.onSecondary,
        size: 26,
      )
          : Icon(
        Icons.android,
        color: Theme.of(context).colorScheme.onSecondary,
        size: 24,
      ),
    );
  }

}
