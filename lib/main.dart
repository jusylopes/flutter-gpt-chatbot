import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/screens/chat_screen.dart';
import 'package:flutter_gpt_chatbot/utils/colors.dart';
import 'package:flutter_gpt_chatbot/utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: ThemeData(
        scaffoldBackgroundColor: GptColors.scaffoldBackgroundColor,
        appBarTheme: const AppBarTheme(color: GptColors.cardColor),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
