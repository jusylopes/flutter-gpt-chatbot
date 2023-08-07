import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/models/chat_model.dart';
import 'package:flutter_gpt_chatbot/repositories/chat_repository.dart';
import 'package:flutter_gpt_chatbot/screens/widgets/chat_widget.dart';
import 'package:flutter_gpt_chatbot/utils/assets_manager.dart';
import 'package:flutter_gpt_chatbot/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late TextEditingController _textEditingController;
  late ScrollController _scrollController;
  late FocusNode _focusNode;
  final _repository = ChatRepository(dio: Dio());
  final _messages = <ChatModel>[];

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _scrollController = ScrollController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  void _sendMessageUser() async {
    final userMessage = _textEditingController.text;

    if (userMessage.isEmpty) {
      _showEmptyMessageSnackBar(context);
      return;
    }

    setState(() {
      _messages.add(ChatModel(
        message: userMessage,
        chatMessageType: ChatMessageType.user,
      ));
      _textEditingController.text = '';
      _scrollToEnd();
    });

    final botResponse = await _getResponseBot(userMessage);

    setState(() {
      _messages.add(ChatModel(
        message: botResponse,
        chatMessageType: ChatMessageType.bot,
      ));
      _scrollToEnd();
    });
  }

  Future<String> _getResponseBot(String message) async {
    return await _repository.getMessageFromChatGPT(message: message);
  }

  void _showEmptyMessageSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please type a message'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 1),
      ),
    );
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
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            toolbarHeight: 60,
            backgroundColor: GptColors.backgroundColor,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      itemBuilder: (_, index) {
                        return ChatWidget(message: _messages[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _textEditingController,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      decoration: InputDecoration(
                          hintText: 'Send a message',
                          hintStyle: const TextStyle(color: Colors.grey),
                          fillColor: GptColors.primaryColor,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: GptColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: GptColors.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                              onPressed: _sendMessageUser,
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.grey,
                              ))),
                      maxLines: 4,
                      minLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
