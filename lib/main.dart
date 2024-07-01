import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/chat_viewmodel.dart';
import 'models/chat_message.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
      ],
      child: MaterialApp(
        title: 'ChatBot App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChatScreen(),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final chatViewModel = Provider.of<ChatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('ChatBot App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: chatViewModel.messages.length,
                itemBuilder: (context, index) {
                  final message = chatViewModel.messages[index];
                  final isUserMessage = message.role == 'user';
                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 5.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      decoration: BoxDecoration(
                        color:
                            isUserMessage ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(message.content),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Enter your prompt'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await chatViewModel.sendMessage(_controller.text);
                _controller.clear();
              },
              child: Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
