import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:astronomy_picture/domain/usercases/search/fetch_search_history.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values..dart';
import 'fetch_apod_by_range_test.mocks.dart';

void main() {
  late MockSearchRepository repository;
  late FetchSearchHistory usecase;

  setUp(() {
    repository = MockSearchRepository();
    usecase = FetchSearchHistory(repository: repository);
  });

  test('Should return a list of String on Right side of either', () async {
    // cenario
    when(repository.fetchSearchHistory())
        .thenAnswer((_) async => Right<Failure, List<String>>(tHistoryList()));

    // ação
    final result = await usecase(NoParameter());

    // esperado
    result.fold(
      (l) => fail('Test failed'),
      (r) => expect(r, tHistoryList()),
    );

    // esperado
    // expect(result, Right<Failure, List<Apod>>(tListApod()));
  });

  test('Should return a failure on left side of the either', () async {
    // cenario
    when(repository.fetchSearchHistory()).thenAnswer(
        (_) async => Left<Failure, List<String>>(AccessLocalDataFailure()));

    // ação
    final result = await usecase(NoParameter());

    // esperado
    expect(result, Left<Failure, Apod>(AccessLocalDataFailure()));
  });
}
