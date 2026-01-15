part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final Map<String, dynamic> port;

  // final VoidCallback onSuccess;
  // final VoidCallback onSelectLanguages;
  // final FormBuilderFields form;

  final Function(String message) onError;

  AuthLoginEvent({
    required this.port,
    required this.onError,
    // required this.onSelectLanguages,
    // required this.form,
    // required this.onIncorrectLoginOrPassword,
  });
}

class AuthRegisterEvent extends AuthEvent {
  final Map<String, dynamic> port;
  final Function(String message) onError;

  // final VoidCallback busyEmail;

  AuthRegisterEvent({
    required this.port,
    required this.onError,
    // required this.busyEmail,
  });
}

//
// class AuthRecoveryRequested extends AuthEvent {
//   final Map<String, dynamic> port;
//   final VoidCallback onSuccess;
//   final VoidCallback onFailure;
//   final FormBuilderFields form;
//
//   AuthRecoveryRequested({
//     required this.port,
//     required this.onSuccess,
//     required this.onFailure,
//     required this.form,
//   });
//
//   @override
//   List<Object> get props => [port, onSuccess, onFailure];
// }
//
// class AuthConfirmRegistrationRequested extends AuthEvent {
//   final int attempts;
//   final String email;
//   final String code;
//   final VoidCallback onSuccess;
//   final Function(String message) onFailure;
//   final GlobalKey<FormBuilderState> formKey;
//
//   AuthConfirmRegistrationRequested({
//     required this.attempts,
//     required this.email,
//     required this.code,
//     required this.onSuccess,
//     required this.onFailure,
//     required this.formKey,
//   });
//
//   @override
//   List<Object> get props => [email, code, onSuccess, onFailure, formKey];
// }
//
// class AuthResendCodeRequested extends AuthEvent {
//   final String email;
//   final int type;
//   final VoidCallback onSuccess;
//   final VoidCallback onFailure;
//
//   AuthResendCodeRequested({
//     required this.email,
//     required this.type,
//     required this.onSuccess,
//     required this.onFailure,
//   });
//
//   @override
//   List<Object> get props => [email, type, onSuccess, onFailure];
// }
//
// class AuthConfirmRecoveryRequested extends AuthEvent {
//   final int attempts;
//   final String email;
//   final String code;
//   final VoidCallback onSuccess;
//   final Function(String message) onFailure;
//   final GlobalKey<FormBuilderState> formKey;
//
//   AuthConfirmRecoveryRequested({
//     required this.attempts,
//     required this.email,
//     required this.code,
//     required this.onSuccess,
//     required this.onFailure,
//     required this.formKey,
//   });
//
//   @override
//   List<Object> get props => [
//     attempts,
//     email,
//     code,
//     onSuccess,
//     onFailure,
//     formKey,
//   ];
// }
//
// class AuthRecoveryVerifyRequested extends AuthEvent {
//   final String email;
//   final String code;
//   final String password;
//   final VoidCallback onSuccess;
//   final VoidCallback onFailure;
//   final GlobalKey<FormBuilderState> formKey;
//
//   AuthRecoveryVerifyRequested({
//     required this.email,
//     required this.code,
//     required this.password,
//     required this.onSuccess,
//     required this.onFailure,
//     required this.formKey,
//   });
//
//   @override
//   List<Object> get props => [
//     email,
//     code,
//     password,
//     onSuccess,
//     onFailure,
//     formKey,
//   ];
// }
//
// class LoadDevicesRequested extends AuthEvent {
//   LoadDevicesRequested();
// }
//
// class DeleteDeviceRequested extends AuthEvent {
//   final String sessionId;
//   final VoidCallback onSuccess;
//   final VoidCallback onFailure;
//
//   DeleteDeviceRequested({
//     required this.sessionId,
//     required this.onSuccess,
//     required this.onFailure,
//   });
//
//   @override
//   List<Object> get props => [sessionId, onSuccess, onFailure];
// }
//
// class DeleteAllOtherDevicesRequested extends AuthEvent {
//   final List<DeviceModel>? devices;
//   final VoidCallback onSuccess;
//   final VoidCallback onFailure;
//
//   DeleteAllOtherDevicesRequested({
//     this.devices,
//     required this.onSuccess,
//     required this.onFailure,
//   });
//
//   @override
//   List<Object> get props => [devices ?? [], onSuccess, onFailure];
// }
//
// class AuthGoogleSignInRequested extends AuthEvent {
//   final VoidCallback onSuccess;
//   final VoidCallback onSelectLanguages;
//   final BuildContext context;
//
//   AuthGoogleSignInRequested({
//     required this.onSuccess,
//     required this.onSelectLanguages,
//     required this.context,
//   });
//
//   @override
//   List<Object> get props => [onSuccess, onSelectLanguages, context];
// }
