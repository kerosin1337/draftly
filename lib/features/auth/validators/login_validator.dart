import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class LoginValidator {
  static FormFieldValidator<String> email = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.email(),
  ]);

  static FormFieldValidator<String> password = FormBuilderValidators.compose([
    FormBuilderValidators.required(),
    FormBuilderValidators.password(
      maxLength: 16,
      minUppercaseCount: 0,
      minLowercaseCount: 0,
      minNumberCount: 0,
      minSpecialCharCount: 0,
    ),
  ]);
}
