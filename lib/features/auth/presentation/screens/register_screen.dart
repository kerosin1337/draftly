import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '/core/theme/app_colors.dart';
import '/features/auth/bloc/auth_bloc.dart';
import '/features/auth/validators/register_validator.dart';
import '/shared/widgets/draftly_button.dart';
import '/shared/widgets/draftly_input.dart';
import '/shared/widgets/draftly_scaffold.dart';
import '/shared/widgets/draftly_snackbar.dart';
import '/shared/widgets/gradient_text.dart';
import '/shared/widgets/keyboard_visibility_builder.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final AuthBloc authBloc = context.read<AuthBloc>();
  final formKey = GlobalKey<FormBuilderState>();

  late final RegisterValidator validator = RegisterValidator(formKey);

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible, _) {
        return DraftlyScaffold(
          isScrollable: isKeyboardVisible,
          body: FormBuilder(
            key: formKey,
            child: Column(
              spacing: 20,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !isKeyboardVisible,
                  child: const Spacer(flex: 2),
                ),
                const GradientText('Регистрация'),
                DraftlyInput(
                  name: 'name',
                  title: 'Имя',
                  placeholder: 'Введите ваше имя',
                  validator: validator.name,
                  textInputAction: TextInputAction.next,
                ),
                DraftlyInput(
                  name: 'email',
                  title: 'e-mail',
                  placeholder: 'Введите электронную почту',
                  validator: validator.email,
                  inputType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: AppColors.greyDark,
                ),
                DraftlyInput(
                  name: 'password',
                  title: 'Пароль',
                  placeholder: '8-16 символов',
                  isPassword: true,
                  validator: validator.password,
                  textInputAction: TextInputAction.next,
                ),
                DraftlyInput(
                  name: 'password_confirmation',
                  title: 'Подтверждение пароля',
                  placeholder: '8-16 символов',
                  isPassword: true,
                  validator: validator.repeatPassword,
                ),
                Visibility(visible: !isKeyboardVisible, child: const Spacer()),
              ],
            ),
          ),
          bottomChild: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return DraftlyButton(
                text: 'Зарегистрироваться',
                onPressed: handleRegister,
                disabled: state is AuthLoading,
              );
            },
          ),
        );
      },
    );
  }

  void handleRegister() {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      authBloc.add(
        AuthRegisterEvent(
          port: formKey.currentState!.value,
          onError: (message) {
            DraftlySnackbar.showSnackBar(context, message);
          },
        ),
      );
    }
  }
}
