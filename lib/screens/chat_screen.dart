import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/utils/assets_manager.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading: Image.asset(AssetsManager.openaiLogo),
      ),
    );
  }
}
