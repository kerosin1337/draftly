import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';
import '/shared/constants/asset_paths.dart';
import '/shared/widgets/draftly_svg.dart';
import 'app_typography.dart';

ThemeData appTheme = ThemeData(
  primaryColor: AppColors.grey,
  appBarTheme: AppBarThemeData(
    backgroundColor: Colors.transparent,
    titleTextStyle: AppTypographyRoboto.regular17px.copyWith(
      color: AppColors.white,
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
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) => const DraftlySvg(
      assetName: SvgAsset.linearArrowLeft,
      width: 24,
      height: 24,
    ),
  ),
);

InputBorder _underlineBorder(Color color) {
  return UnderlineInputBorder(borderSide: BorderSide(color: color));
}
