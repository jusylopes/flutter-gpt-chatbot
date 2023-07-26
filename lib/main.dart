import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gpt Chatbot',
      theme: ThemeData(
        scaffoldBackgroundColor: GptColors.scaffoldBackgroundColor,
        useMaterial3: true,
      ),
    );
  }
}
