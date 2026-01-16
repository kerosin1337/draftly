part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final Map<String, dynamic> port;

  final Function(String message) onError;

  AuthLoginEvent({required this.port, required this.onError});
}

class AuthRegisterEvent extends AuthEvent {
  final Map<String, dynamic> port;
  final Function(String message) onError;

  AuthRegisterEvent({required this.port, required this.onError});
}

class AuthLogoutEvent extends AuthEvent {
  final Function() onSuccess;

  AuthLogoutEvent({required this.onSuccess});
}
