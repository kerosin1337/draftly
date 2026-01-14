import 'package:draftly/core/theme/app_colors.dart';
import 'package:draftly/shared/widgets/draftly_input.dart';
import 'package:draftly/shared/widgets/draftly_scaffold.dart';
import 'package:draftly/shared/widgets/gradient_text.dart';
import 'package:flutter/material.dart';

import '../../../../shared/widgets/draftly_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DraftlyScaffold(
      body: Column(
        spacing: 20,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          const GradientText('Регистрация'),
          DraftlyInput(title: 'Имя', placeholder: 'Введите ваше имя'),
          DraftlyInput(
            title: 'e-mail',
            placeholder: 'Введите электронную почту',
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: AppColors.greyDark,
          ),
          DraftlyInput(
            title: 'Пароль',
            placeholder: '8-16 символов',
            isPassword: true,
          ),
          DraftlyInput(
            title: 'Подтверждение пароля',
            placeholder: '8-16 символов',
            isPassword: true,
          ),
          const Spacer(),
          DraftlyButton(
            text: 'Зарегистрироваться',
            onPressed: () {},
            disabled: true,
          ),
        ],
      ),
    );
  }
}
