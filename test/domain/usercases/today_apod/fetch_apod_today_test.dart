import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/repositories/today_apod/today_apod_repository.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:astronomy_picture/domain/usercases/today_apod/fetch_apod_today.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../test_values..dart';
import 'fetch_apod_today_test.mocks.dart';

@GenerateNiceMocks([MockSpec<TodayApodRepository>()])
void main() {
  late MockTodayApodRepository repository;
  late FetchApodToday userCase;

  setUp(() {
    repository = MockTodayApodRepository();
    userCase = FetchApodToday(repository: repository);
  });

  // Retornar Apod
  test('Shold to return a Apod entity on right side of the Either', () async {
    // Cenário
    when(repository.fetchApodToday())
        .thenAnswer((_) async => Right<Failure, Apod>(tApod()));
    // Ação
    final result = await userCase(NoParameter());
    // Esperado
    expect(result, Right<Failure, Apod>(tApod()));
  });

  // Retornar falha
  test('Shold to return a failure on left side of the Either', () async {
    // Cenário
    when(repository.fetchApodToday())
        .thenAnswer((_) async => Left<Failure, Apod>(tNoConnection()));
    // Ação
    final result = await userCase(NoParameter());
    // Esperado
    expect(result, Left<Failure, Apod>(tNoConnection()));
  });
}
