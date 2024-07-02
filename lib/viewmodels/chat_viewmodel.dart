import 'package:flutter/material.dart';
import '../services/chat_service.dart';
import '../services/product_service.dart';
import '../models/chat_message.dart';
import '../models/product.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatGPTService _chatGPTService = ChatGPTService();
  final ProductService _productService = ProductService();
  List<ChatMessage> _messages = [];

  ChatViewModel() {
    _loadProducts();
  }

  List<ChatMessage> get messages => _messages;

  Future<void> _loadProducts() async {
    await _productService.loadProducts();
  }

  Future<void> sendMessage(String prompt) async {
    _messages.add(ChatMessage(prompt, 'user'));
    notifyListeners();

    // Check for recommendation request
    if (prompt.toLowerCase().contains('recommend')) {
      final keyword = prompt.split('recommend').last.trim();
      final recommendedProducts = _productService.recommendProducts(keyword);
      final response = _formatProductRecommendations(recommendedProducts);
      _messages.add(ChatMessage(response, 'assistant'));
    } else {
      final response = await _chatGPTService.getChatResponse(prompt);
      _messages.add(ChatMessage(response, 'assistant'));
    }
    notifyListeners();
  }

  String _formatProductRecommendations(List<Product> products) {
    if (products.isEmpty) {
      return 'No products found for the specified keyword.';
    }

    return products
        .map((product) => 'Product Name: ${product.productName}\n'
            'Company: ${product.companyName}\n'
            'Contact: ${product.contactPhone}\n'
            'Website: ${product.companyWebsite}\n'
            'Functions: ${product.mainFunctions}\n'
            'How to Use: ${product.howToUse}\n'
            'Summary: ${product.productSummary}')
        .join('\n\n');
  }
}
