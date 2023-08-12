import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpt_chatbot/providers/chat_provider.dart';
import 'package:flutter_gpt_chatbot/repositories/chat_repository.dart';
import 'package:flutter_gpt_chatbot/screens/chat_screen.dart';
import 'package:flutter_gpt_chatbot/utils/colors.dart';
import 'package:flutter_gpt_chatbot/utils/constants.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ChatProvider(
            repository: ChatRepository(dio: Dio()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Constants.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: GptColors.backgroundColor,
          appBarTheme: const AppBarTheme(color: GptColors.primaryColor),
          useMaterial3: true,
        ),
        home: const ChatScreen(),
      ),
    );
  }
}
