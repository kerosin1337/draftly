import 'package:draftly/core/theme/app_colors.dart';
import 'package:draftly/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class GradientText extends StatelessWidget {
  final String text;

  const GradientText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: AppTypographyPressStart2P.regular20px.copyWith(
            color: Colors.transparent,
            shadows: [
              const Shadow(
                color: AppColors.gradientStart,
                blurRadius: 15,
                offset: Offset(3, -3),
              ),
              const Shadow(
                color: AppColors.gradientEnd,
                blurRadius: 15,
                offset: Offset(-3, 3),
              ),
              const Shadow(
                color: AppColors.gradientStart,
                blurRadius: 15,
                offset: Offset(-3, -3),
              ),
              const Shadow(
                color: AppColors.gradientEnd,
                blurRadius: 15,
                offset: Offset(3, 3),
              ),
            ],
          ),
        ),
        Text(
          text,
          style: AppTypographyPressStart2P.regular20px.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
