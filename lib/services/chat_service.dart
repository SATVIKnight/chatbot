import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatGPTService {
  final String apiKey =
      'sk-proj-4NESHvJFdtSCHd6dAdmgT3BlbkFJs9arVlXxo2fvszrtGDVy';

  Future<String> getChatResponse(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo', // Ensure this matches the correct model name
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
        'max_tokens': 100,
      }),
    );

    print('Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to load response: ${response.body}');
    }
  }
}
