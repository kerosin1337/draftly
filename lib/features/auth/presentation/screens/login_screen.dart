import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';

import '/features/auth/bloc/auth_bloc.dart';
import '/features/auth/validators/login_validator.dart';
import '/shared/constants/durations.dart';
import '/shared/widgets/draftly_button.dart';
import '/shared/widgets/draftly_input.dart';
import '/shared/widgets/draftly_scaffold.dart';
import '/shared/widgets/draftly_snackbar.dart';
import '/shared/widgets/gradient_text.dart';
import '/shared/widgets/keyboard_visibility_builder.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StreamSubscription<User?>? streamSubscription;

  final formKey = GlobalKey<FormBuilderState>();

  late final AuthBloc authBloc = context.read<AuthBloc>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    streamSubscription = FirebaseAuth.instance.authStateChanges().listen((
      user,
    ) {
      Future.delayed(defaultDelay, () {
        if (user != null && mounted) {
          context.go('/');
        }
        if (isLoading) {
          setState(() {
            isLoading = false;
          });
        }
      });
    });
  }

  @override
  void dispose() {
    streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible, _) {
        return DraftlyScaffold(
          isLoading: isLoading,
          isScrollable: isKeyboardVisible,
          body: FormBuilder(
            key: formKey,
            child: Column(
              spacing: 20,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: !isKeyboardVisible,
                  child: const Spacer(flex: 2),
                ),
                const GradientText('Вход'),
                DraftlyInput(
                  name: 'email',
                  title: 'e-mail',
                  placeholder: 'Введите электронную почту',
                  validator: LoginValidator.email,
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                DraftlyInput(
                  name: 'password',
                  title: 'Подтверждение пароля',
                  placeholder: 'Введите пароль',
                  isPassword: true,
                  validator: LoginValidator.password,
                ),
                Visibility(visible: !isKeyboardVisible, child: const Spacer()),
              ],
            ),
          ),
          bottomChild: Column(
            spacing: 20,
            children: [
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return DraftlyButton(
                    text: 'Войти',
                    onPressed: handleLogin,
                    disabled: state is AuthLoading,
                  );
                },
              ),
              DraftlyButton(
                text: 'Регистрация',
                type: DraftlyButtonType.stroke,
                onPressed: handleNavigateRegister,
              ),
            ],
          ),
        );
      },
    );
  }

  void handleLogin() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      authBloc.add(
        AuthLoginEvent(
          port: formKey.currentState!.value,
          onError: (message) {
            DraftlySnackbar.showSnackBar(context, message);
          },
        ),
      );
    }
  }

  void handleNavigateRegister() {
    context.push('/register');
  }
}
