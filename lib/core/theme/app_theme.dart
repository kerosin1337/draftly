import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';

ThemeData appTheme = ThemeData(
  fontFamily: 'Roboto',
  appBarTheme: AppBarThemeData(
    backgroundColor: const Color(0xffc4c4c4).withAlpha((255 * 0.01).toInt()),
    shape: const RoundedSuperellipseBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
    ),
    elevation: 0,
  ),
  inputDecorationTheme: const InputDecorationThemeData(
    labelStyle: TextStyle(fontFamily: '', color: AppColors.grey, fontSize: 12),
  ),
);
