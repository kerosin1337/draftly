import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';
import '/core/theme/app_typography.dart';

enum DraftlyButtonType { active, stroke, negative }

class DraftlyButton extends StatelessWidget {
  final String text;
  final DraftlyButtonType type;
  final bool disabled;
  final VoidCallback onPressed;

  final TextStyle textStyle;
  final EdgeInsets padding;

  const DraftlyButton({
    super.key,
    required this.text,
    this.type = DraftlyButtonType.active,
    this.disabled = false,
    required this.onPressed,
  }) : textStyle = AppTypographyRoboto.regular17px,
       padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  const DraftlyButton.small({
    super.key,
    required this.text,
    this.type = DraftlyButtonType.active,
    this.disabled = false,
    required this.onPressed,
  }) : textStyle = AppTypographyRoboto.regular15px,
       padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: disabled ? null : onPressed,
        child: Ink(
          width: double.infinity,
          padding: padding,
          decoration: containerDecoration,
          child: Text(
            text,
            style: textStyle.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Color get textColor {
    if (disabled) return AppColors.greyDark;
    return switch (type) {
      DraftlyButtonType.active => AppColors.white,
      DraftlyButtonType.negative => Colors.white,
      DraftlyButtonType.stroke => AppColors.bg,
    };
  }

  BoxDecoration get containerDecoration {
    if (disabled) {
      return const BoxDecoration(color: AppColors.grey);
    }
    if (type == DraftlyButtonType.active) {
      return const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: AppColors.gradient,
        ),
      );
    } else {
      return BoxDecoration(
        color: type == DraftlyButtonType.negative
            ? AppColors.red
            : AppColors.white,
      );
    }
  }
}
