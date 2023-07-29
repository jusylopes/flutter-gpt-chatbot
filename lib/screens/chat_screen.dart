import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/utils/assets_manager.dart';
import 'package:flutter_gpt_chatbot/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _textEditingController;

  late FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: const Text(
            'ChatGPT',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 25),
          ),
          actions: [
            IconButton(
              onPressed: () async {},
              icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
            ),
          ],
          toolbarHeight: 60,
        ),
        body: SafeArea(
            child: Column(children: [
          const Flexible(child: Center()),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: GptColors.cardColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        focusNode: _focusNode,
                        style: const TextStyle(color: Colors.white),
                        controller: _textEditingController,
                        decoration: const InputDecoration.collapsed(
                            hintText: 'Send a message',
                            hintStyle: TextStyle(color: Colors.grey)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.grey,
                        ))
                  ],
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}
