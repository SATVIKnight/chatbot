import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';
import '../models/product.dart';
import '../services/chat_service.dart';

class ProductService {
  List<Product> _products = [];

  Future<void> loadProducts() async {
    final data = await rootBundle.load('assets/products.xlsx');
    final bytes = data.buffer.asUint8List();
    final excel = Excel.decodeBytes(bytes);

    final sheet = excel.tables.keys.first;
    final rows = excel.tables[sheet]?.rows ?? [];

    _products = rows.skip(1).map((row) => Product.fromExcel(row)).toList();
  }

  Future<List<String>> recommendProducts(String prompt) async {
    final chatGPTService = ChatGPTService();
    final productDescriptions =
        _products.map((product) => product.productSummary).toList();
    final recommendationPrompt =
        'Based on the following product descriptions, recommend product names related to: $prompt\n\n' +
            productDescriptions.join('\n\n');

    final response = await chatGPTService.getChatResponse(recommendationPrompt);
    return _extractProductNames(response);
  }

  List<String> _extractProductNames(String response) {
    // Implement a method to extract product names from the response
    // For simplicity, assuming response is a newline-separated list of product names
    return response
        .split('\n')
        .map((name) => name.trim())
        .where((name) => name.isNotEmpty)
        .toList();
  }
}
