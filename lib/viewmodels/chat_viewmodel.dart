import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import '../models/chat_message.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatGPTService _chatGPTService = ChatGPTService();
  List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  Future<void> sendMessage(String prompt) async {
    _messages.add(ChatMessage(prompt, 'user'));
    notifyListeners();

    final response = await _chatGPTService.getChatResponse(prompt);
    _messages.add(ChatMessage(response, 'assistant'));
    notifyListeners();
  }
}
