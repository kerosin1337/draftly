import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '/core/theme/app_colors.dart';
import '/core/theme/app_typography.dart';

class DraftlyInput extends StatefulWidget {
  final String name;
  final String title;
  final String placeholder;
  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final TextInputAction? textInputAction;

  final FocusNode focusNode = FocusNode();

  DraftlyInput({
    super.key,
    required this.name,
    required this.title,
    required this.placeholder,
    this.isPassword = false,
    this.validator,
    this.inputType,
    this.textInputAction,
  });

  @override
  State<DraftlyInput> createState() => _DraftlyInputState();
}

class _DraftlyInputState extends State<DraftlyInput> {
  final FocusNode focusNode = FocusNode();

  String get name => widget.name;

  String get title => widget.title;

  String get placeholder => widget.placeholder;

  bool get isPassword => widget.isPassword;

  FormFieldValidator<String>? get validator => widget.validator;

  TextInputType? get inputType => widget.inputType;

  TextInputAction? get textInputAction => widget.textInputAction;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: focusNode.requestFocus,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: ShapeDecoration(
          color: AppColors.innerShadow,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(
              color: AppColors.grey,
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: DecoratedBox(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.bg,
                  blurRadius: 40,
                  spreadRadius: 10,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12, color: AppColors.grey),
                ),
                const SizedBox(height: 8),
                FormBuilderTextField(
                  name: name,
                  focusNode: focusNode,
                  obscureText: isPassword,
                  validator: validator,
                  keyboardType: inputType,
                  textInputAction: textInputAction,
                  style: AppTypographyRoboto.regular14px.copyWith(
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: placeholder,
                    hintStyle: const TextStyle(color: AppColors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
