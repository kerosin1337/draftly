import 'package:draftly/shared/widgets/draftly_button.dart';
import 'package:draftly/shared/widgets/draftly_input.dart';
import 'package:draftly/shared/widgets/draftly_scaffold.dart';
import 'package:draftly/shared/widgets/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/keyboard_visibility_builder.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible, _) {
        return DraftlyScaffold(
          key: ValueKey('23123123'),
          isScrollable: isKeyboardVisible,
          body: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (!isKeyboardVisible) const Spacer(flex: 2),
              const GradientText('Вход'),
              DraftlyInput(
                title: 'e-mail',
                placeholder: 'Введите электронную почту',
              ),
              DraftlyInput(
                title: 'Подтверждение пароля',
                placeholder: 'Введите пароль',
                isPassword: true,
              ),
              // if (!isKeyboardVisible) const Spacer(),
              DraftlyButton(text: 'Войти', onPressed: () {}),
              DraftlyButton(
                text: 'Регистрация',
                type: DraftlyButtonType.stroke,
                onPressed: handleNavigateRegister(context),
              ),
            ],
          ),
        );
      },
    );
  }

  VoidCallback handleNavigateRegister(BuildContext context) {
    return () {
      context.push('/register');
    };
  }
}
