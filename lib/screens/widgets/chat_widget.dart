import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/models/chat_model.dart';
import 'package:flutter_gpt_chatbot/utils/assets_manager.dart';
import 'package:flutter_gpt_chatbot/utils/colors.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required ChatModel message,
  }) : _message = message;

  final ChatModel _message;

  @override
  Widget build(BuildContext context) {
    final bool isBotMessage = _message.chatMessageType == ChatMessageType.bot;

    return Row(
      children: [
        if (isBotMessage) const Spacer(),
        Row(
          children: [
            if (isBotMessage)
              Image.asset(AssetsManager.appLogo, height: 40, width: 40),
            Container(
              margin: const EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isBotMessage
                    ? GptColors.backgroundColor
                    : GptColors.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _message.message,
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        )
      ],
    );
  }
}
