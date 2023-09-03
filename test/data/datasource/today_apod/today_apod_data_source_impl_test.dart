import 'dart:convert';
import 'dart:io';

import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../fixtures/fixtures.dart';
import '../../../mocks/mocks.mocks.dart';
import '../../../test_values..dart';

void main() {
  late MockClient client;
  late TodayApodDataSourceImpl dataSource;

  setUp(() {
    client = MockClient();
    dataSource = TodayApodDataSourceImpl(client: client);
  });

  group('Function fetchTodayApod', () {
    // Sucesso = Apod

    test('Shold to return a apod model', () async {
      when(client.get(any)).thenAnswer((_) async => http.Response.bytes(
          utf8.encode(fixture('image_response.json')), 200));

      final result = await dataSource.fetchTodayApod();

      expect(result, tApodModel());
    });

    // Falha1 = ApiFailure statusCode != 200

    test(
        'Shold throw a api failure when the api to return a different value of the 200',
        () async {
      when(client.get(any)).thenAnswer((_) async => http.Response.bytes(
          utf8.encode(fixture('image_response.json')), 500));

      expect(() => dataSource.fetchTodayApod(), throwsA(isA<ApiFailure>()));
    });

    // Falha2 = ApiFailure client exeption

    test('Shold throw a api failure when has exeption', () async {
      when(client.get(any)).thenThrow(const SocketException('message'));

      expect(() => dataSource.fetchTodayApod(), throwsA(isA<ApiFailure>()));
    });
  });
}
