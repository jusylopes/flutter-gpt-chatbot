import 'package:dio/dio.dart';

class ChatRepository {
  final Dio _dio;

  ChatRepository({required dio}) : _dio = dio;

  static const _openaiBaseUrl = 'https://api.openai.com/v1';
  String apiToken = '';

  Future<String> getMessageFromChatGPT({
    required String message,
  }) async {
    try {
      Response response = await _dio.post('$_openaiBaseUrl/completions',
          data: {
            "model": "text-davinci-003",
            "prompt": "Say this is a test",
            "max_tokens": 7,
            "temperature": 0
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $apiToken',
              'Content-Type': 'application/json',
            },
          ));

      return (response.data['choices'][0]['text'] as String)
          .replaceFirst("\n", "")
          .replaceFirst("\n", "");
    } catch (error) {
      throw Exception('Failed to load text: $error');
    }
  }
}
