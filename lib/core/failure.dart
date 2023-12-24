import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String get msg;

  @override
  List<Object?> get props => [];
}

class NoConnection extends Failure {
  @override
  String get msg => 'Sorry! You not have connection!';
}

class ApiFailure extends Failure {
  @override
  String get msg => 'Sorry! It was not possible to access the Server';
}

class ConvertFailure extends Failure {
  @override
  String get msg => 'Sorry! your query is not in a right format';
}

class AccessLocalDataFailure extends Failure {
  @override
  String get msg => 'Sorry! there was problem accesing local data';
}
