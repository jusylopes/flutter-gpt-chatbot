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
            'model': 'text-davinci-003',
            'prompt': message,
            'max_tokens': 7,
          },
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $apiToken',
            },
          ));

      return (response.data['choices'][0]['text'] as String);
    } catch (error) {
      throw Exception('Failed to load text: $error');
    }
  }
}
