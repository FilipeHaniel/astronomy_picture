import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  /// if true, has connection
  /// if false, has no connection

  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker _internetConnection;

  NetworkInfoImpl({required InternetConnectionChecker internetConnection})
      : _internetConnection = internetConnection;

  @override
  Future<bool> get isConnected async => await _internetConnection.hasConnection;
}
