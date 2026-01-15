import 'package:draftly/shared/constants/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegisterValidator {
  final GlobalKey<FormBuilderState> _formKey;

  RegisterValidator(this._formKey);

  FormFieldValidator<String> name = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.maxLength(16),
  ]);

  FormFieldValidator<String> email = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.email(),
  ]);

  FormFieldValidator<String> get password => FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.password(
      maxLength: 16,
      minUppercaseCount: 0,
      minLowercaseCount: 0,
      minNumberCount: 0,
      minSpecialCharCount: 0,
    ),
    (value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_formKey.currentState?.fields['repeatPassword']?.value == value &&
            (_formKey.currentState?.fields['repeatPassword']?.hasError ??
                false)) {
          _formKey.currentState?.fields['repeatPassword']?.didChange(value);
        }
      });
      return null;
    },
  ]);

  FormFieldValidator<String> get repeatPassword =>
      FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        password,
        (value) {
          final passwordValue =
              _formKey.currentState?.fields['password']?.value;
          if (passwordValue != value) {
            return getErrorMessage('password-match-validator');
          }
          return null;
        },
      ]);
}
