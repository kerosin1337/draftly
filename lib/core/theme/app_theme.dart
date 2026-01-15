import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';

ThemeData appTheme = ThemeData(
  primaryColor: AppColors.grey,
  appBarTheme: AppBarThemeData(
    backgroundColor: const Color(0xffc4c4c4).withAlpha((255 * 0.01).toInt()),
    shape: const RoundedSuperellipseBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
    ),
    elevation: 0,
  ),
  inputDecorationTheme: InputDecorationThemeData(
    labelStyle: const TextStyle(color: AppColors.grey, fontSize: 12),
    enabledBorder: _underlineBorder(AppColors.grey),
    focusedBorder: _underlineBorder(AppColors.grey),
    errorBorder: _underlineBorder(AppColors.red),
    focusedErrorBorder: _underlineBorder(AppColors.red),
    errorStyle: const TextStyle(color: AppColors.red, fontSize: 12),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: AppColors.grey,
    selectionColor: AppColors.grey,
    selectionHandleColor: AppColors.grey,
  ),
  snackBarTheme: const SnackBarThemeData(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    dismissDirection: DismissDirection.horizontal,
    elevation: 0,
  ),
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(14)),
    elevation: 1,
    menuPadding: const EdgeInsets.all(16),
  ),
);

InputBorder _underlineBorder(Color color) {
  return UnderlineInputBorder(borderSide: BorderSide(color: color));
}
