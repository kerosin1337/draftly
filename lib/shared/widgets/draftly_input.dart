import 'dart:ui';

import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';

class DraftlyInput extends StatelessWidget {
  final String title;
  final String placeholder;
  final bool isPassword;

  // final FocusNode focusNode = FocusNode();

  DraftlyInput({
    super.key,
    required this.title,
    required this.placeholder,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: focusNode.requestFocus,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: const ShapeDecoration(
          color: Color(0xFF131313),
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            side: BorderSide(
              color: AppColors.grey,
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          shadows: [
            BoxShadow(
              color: AppColors.innerShadow,
              blurRadius: 40,
              blurStyle: BlurStyle.inner,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: AppColors.grey),
              ),
              const SizedBox(height: 8),
              TextField(
                // focusNode: focusNode,
                obscureText: isPassword,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  height: 24 / 14,
                ),
                decoration: InputDecoration(
                  isDense: true,
                  hintText: placeholder,
                  hintStyle: const TextStyle(color: AppColors.grey),
                  border: InputBorder.none,
                ),
              ),
              Container(color: Colors.grey, height: 0.3),
            ],
          ),
        ),
      ),
    );
  }
}
