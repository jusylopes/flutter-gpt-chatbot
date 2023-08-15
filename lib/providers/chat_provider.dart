import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/models/chat_model.dart';
import 'package:flutter_gpt_chatbot/repositories/chat_repository.dart';

class ChatProvider with ChangeNotifier {
  final ChatRepository _repository;

  ChatProvider({required ChatRepository repository}) : _repository = repository;

  final List<ChatModel> _chatMessages = [];
  List<ChatModel> get getChatMessages => _chatMessages;

  void addUserMsg({required String message}) {
    _chatMessages.add(
        ChatModel(message: message, chatMessageType: ChatMessageType.user));
    notifyListeners();
  }

  Future<void> addBotMessage({required String message}) async {
    try {
      String botResponse =
          await _repository.getMessageFromChatGPT(message: message);

      _chatMessages.add(ChatModel(
          message: botResponse, chatMessageType: ChatMessageType.bot));
      notifyListeners();
    } catch (error) {
      print('Error sending message: $error');
    }
  }
}
