part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

//
// class AuthLoginLoading extends AuthState {}
//
// class AuthGoogleSignInLoading extends AuthState {}
//
// class AuthLogout extends AuthState {}
//
// class AuthSuccess extends AuthState {
//   final UserModel user;
//
//   AuthSuccess(this.user);
//
//   @override
//   List<Object> get props => [user];
// }
//
// class AuthFailure extends AuthState {
//   final String error;
//   final AuthErrorType errorType;
//
//   AuthFailure(this.error, {this.errorType = AuthErrorType.general});
//
//   @override
//   List<Object> get props => [error, errorType];
// }
//
// enum AuthErrorType { invalidCredentials, networkError, serverError, general }
//
// class DevicesLoaded extends AuthState {
//   final List<DeviceModel> devices;
//
//   DevicesLoaded(this.devices);
//
//   @override
//   List<Object> get props => [devices];
// }
//
// class DevicesLoadFailure extends AuthState {
//   final String error;
//
//   DevicesLoadFailure(this.error);
//
//   @override
//   List<Object> get props => [error];
// }
//
// class DeviceDeleted extends AuthState {}
//
// class AllOtherDevicesDeleted extends AuthState {}
