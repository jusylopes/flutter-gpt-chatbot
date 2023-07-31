import 'package:dio/dio.dart';
import 'package:flutter_gpt_chatbot/models/openai_api_model.dart';
import 'package:flutter_gpt_chatbot/repositories/adapters/adapter_interface.dart';
import 'package:flutter_gpt_chatbot/repositories/api_base_options.dart';
import 'package:flutter_gpt_chatbot/repositories/repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Repository Agent', () {
    late Repository repository;
    late OpenaiAdapter openaiAdapter;
    late Dio dio;

    setUp(() {
      dio = Dio(dioOptions);
      openaiAdapter = OpenaiAdapter();
      repository = Repository(dio: dio, adapter: openaiAdapter);
    });

    group('getModels', () {
      test(
        'getModels should return a list of OpenaiModel',
        () async {
          final openaiModels =
              await repository.getData(endpoint: openApiModelEndpoint);
          final OpenaiModel model = openaiModels[0];

          expect(openaiModels, isA<List<OpenaiModel>>());
          expect(model.id, 'babbage');
          expect(model.created, 1649358449);
        },
      );
    });
  });
}
