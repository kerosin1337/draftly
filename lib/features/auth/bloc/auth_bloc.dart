import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/shared/constants/error_message.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLoginEvent);
    on<AuthRegisterEvent>(_onRegisterEvent);
    on<AuthLogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final port = event.port;

      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(
            email: port['email'],
            password: port['password'],
          );
    } on FirebaseAuthException catch (e) {
      event.onError(getErrorMessage(e.code));
    } finally {
      emit(AuthInitial());
    }
  }

  Future<void> _onRegisterEvent(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final port = event.port;

      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(
            email: port['email'],
            password: port['password'],
          );

      await userCredential.user!.updateDisplayName(event.port['name']);
      await userCredential.user!.reload();
    } on FirebaseAuthException catch (e) {
      print(e.code);
      event.onError(getErrorMessage(e.code));
    } finally {
      emit(AuthInitial());
    }
  }

  Future<void> _onLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await auth.signOut();
      event.onSuccess();
    } on FirebaseAuthException catch (e) {
      print(e.code);
    }
  }
}
