import 'dart:async';

import 'package:astronomy_picture/domain/entities/apod.dart';
import 'package:astronomy_picture/domain/usercases/core/user_case.dart';
import 'package:astronomy_picture/domain/usercases/today_apod/fetch_apod_today.dart';
import 'package:equatable/equatable.dart';

part 'today_apod_event.dart';
part 'today_apod_state.dart';

class TodayApodBloc {
  final FetchApodToday _fetchApodToday;

  TodayApodBloc({required FetchApodToday fetchApodToday})
      : _fetchApodToday = fetchApodToday {
    _inputController.stream.listen(_blocEventController);
  }

  final StreamController<TodayApodEvent> _inputController =
      StreamController<TodayApodEvent>();

  final StreamController<TodayApodState> _outputController =
      StreamController<TodayApodState>();

  Sink<TodayApodEvent> get input => _inputController.sink;
  Stream<TodayApodState> get stream => _outputController.stream;

  void _blocEventController(TodayApodEvent event) {
    _outputController.add(LoadingTodayApodState());

    if (event is FetchApodTodayEvent) {
      _fetchApodToday(NoParameter()).then((value) => value.fold(
            (l) => _outputController.add(ErrorTodayApodState(msg: l.msg)),
            (r) => _outputController.add(SuccessTodayApodState(apod: r)),
          ));
    }
  }
}
