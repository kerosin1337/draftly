import 'package:draftly/shared/constants/error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLoginEvent);
    on<AuthRegisterEvent>(_onRegisterEvent);
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
      print(userCredential.user);
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

      print(userCredential);
    } on FirebaseAuthException catch (e) {
      print(e.code);
      event.onError(getErrorMessage(e.code));
    } finally {
      emit(AuthInitial());
    }
  }
}
