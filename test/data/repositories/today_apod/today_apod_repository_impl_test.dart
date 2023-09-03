import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/data/datasources/network/network_info.dart';
import 'package:astronomy_picture/data/datasources/today_apod/today_apod_data_source.dart';
import 'package:astronomy_picture/data/repositories/today_apod/today_apod_repository_impl.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values..dart';
import 'today_apod_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TodayApodDataSource>(),
  MockSpec<NetworkInfo>(),
])
void main() {
  late MockTodayApodDataSource dataSource;
  late MockNetworkInfo networkInfo;

  late TodayApodRepositoryImpl repository;

  setUp(() {
    dataSource = MockTodayApodDataSource();
    networkInfo = MockNetworkInfo();
    repository = TodayApodRepositoryImpl(
        dataSource: dataSource, networkInfo: networkInfo);
  });

  group('function fetchTodayApod', () {
    //  com internet = sucesso ApodModel
    test('shold to return a entity on a right side of the either', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.fetchTodayApod()).thenAnswer((_) async => tApodModel());

      final result = await repository.fetchApodToday();

      expect(result, Right<Failure, Apod>(tApodModel()));
    });

    // Sem internet = falhar
    test(
        'shold to return a failure on left side of the either coming from datasource',
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      when(dataSource.fetchTodayApod()).thenThrow(ApiFailure());

      final result = await repository.fetchApodToday();

      expect(result, Left<Failure, Apod>(ApiFailure()));
    });

    // com internet = falhar ApodModel
    test(
        'shold to return a failure on left side of the either of NoConnection type',
        () async {
      when(networkInfo.isConnected).thenAnswer((_) async => false);

      final result = await repository.fetchApodToday();

      verifyNever(dataSource.fetchTodayApod());

      expect(result, Left<Failure, Apod>(NoConnection()));
    });
  });
}
