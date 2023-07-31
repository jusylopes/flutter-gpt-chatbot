import 'package:flutter_gpt_chatbot/models/openai_api_model.dart';
import 'package:flutter_gpt_chatbot/repositories/adapters/adapter_interface.dart';
import 'package:flutter_gpt_chatbot/repositories/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';

import '../mocks/mock_data.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('Repository GetModel', () {
    late MockDio dio;
    late Repository repository;
    late OpenaiAdapter openaiAdapter;

    final response = Response(
      statusCode: 200,
      data: MockData.jsonMockOpenaiModel,
      requestOptions: RequestOptions(path: '/'),
    );

    setUp(() {
      dio = MockDio();
      openaiAdapter = OpenaiAdapter();

      repository = Repository(dio: dio, adapter: openaiAdapter);
      when(() => dio.get(any())).thenAnswer((_) async => response);
    });

    group('getModels', () {
      test('getModels should return a list of OpenaiModel', () async {
        final openaiModels = await repository.getData(endpoint: '');
        final OpenaiModel model = openaiModels[0];

        expect(openaiModels, isA<List<OpenaiModel>>());
        expect(model.id, 'babbage');
        expect(model.created, 1649358449);
      });
    });
  });
}
