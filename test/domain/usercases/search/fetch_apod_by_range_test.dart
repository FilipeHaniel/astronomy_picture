import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/search/search_repository.dart';
import 'package:astronomy_picture/domain/usercases/search/fetch_apod_by_data_range.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values..dart';
import 'fetch_apod_by_range_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SearchRepository>()])
void main() {
  late MockSearchRepository repository;
  late FetchApodByDataRange usecase;

  setUp(() {
    repository = MockSearchRepository();
    usecase = FetchApodByDataRange(repository: repository);
  });

  test('Should return a list of Apod entity Right side of either', () async {
    // cenario
    when(repository.fetchApodByDateRange(any, any))
        .thenAnswer((_) async => Right<Failure, List<Apod>>(tListApod()));

    // ação
    final result = await usecase('2022-05-05/2022-05-01');

    // esperado
    result.fold(
      (l) => expect(0, 1),
      (r) => expect(r, tListApod()),
    );

    // esperado
    // expect(result, Right<Failure, List<Apod>>(tListApod()));
  });

  test('Should return a failure on left side of the either', () async {
    // cenario
    when(repository.fetchApodByDateRange(any, any))
        .thenAnswer((_) async => Left<Failure, List<Apod>>(NoConnection()));

    // ação
    final result = await usecase('2022-05-05/2022-05-01');

    // esperado
    expect(result, Left<Failure, Apod>(NoConnection()));
  });

  test(
      'Should return a failure on left side  of the either for incorrect input',
      () async {
    final result = await usecase('2022-5-05/2022-05-01');

    expect(result, Left<Failure, Apod>(ConvertFailure()));
  });
}
