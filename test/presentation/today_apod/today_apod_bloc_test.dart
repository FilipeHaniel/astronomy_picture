import 'package:astronomy_picture/core/failure.dart';
import 'package:astronomy_picture/domain/usercases/today_apod/fetch_apod_today.dart';
import 'package:astronomy_picture/presentation/bloc/today_apod/today_apod_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../test_values..dart';
import 'today_apod_bloc_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchApodToday>()])
void main() {
  late MockFetchApodToday fetchApodToday;
  late TodayApodBloc bloc;

  setUp(() {
    fetchApodToday = MockFetchApodToday();
    bloc = TodayApodBloc(fetchApodToday: fetchApodToday);
  });

  group('usecase - fetchTodayApod', () {
    // Sucesso
    test('Shold to emitter LoadingApodState and SuccessApodState', () {
      when(fetchApodToday(any)).thenAnswer((_) async => Right(tApod()));

      bloc.input.add(FetchApodTodayEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          LoadingTodayApodState(),
          SuccessTodayApodState(apod: tApod()),
        ]),
      );
    });

    // Falha
    test('Shold to emitter LoadingApodState and ErrorApodState', () {
      when(fetchApodToday(any)).thenAnswer((_) async => Left(NoConnection()));

      bloc.input.add(FetchApodTodayEvent());

      expect(
        bloc.stream,
        emitsInOrder([
          LoadingTodayApodState(),
          ErrorTodayApodState(msg: tNoConnection().msg),
        ]),
      );
    });
  });
}
