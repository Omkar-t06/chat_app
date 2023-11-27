import 'package:chatting_app/chat_page.dart';
import 'package:chatting_app/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat App",
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: LoginPage(),
      routes: {
        '/chat': (context) => const ChatPage(),
      },
    );
  }
}
