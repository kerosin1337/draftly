import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';
import '/core/theme/app_typography.dart';
import '/shared/constants/asset_paths.dart';
import 'draftly_svg.dart';

class DraftlySnackbar {
  static void clearSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static void showSnackBar(BuildContext context, String message) {
    _showSnackBar(context, message);
  }

  static void _showSnackBar(BuildContext context, String message) {
    final ScaffoldMessengerState scaffoldMessenger = ScaffoldMessenger.of(
      context,
    );

    scaffoldMessenger.showSnackBar(
      SnackBar(
        margin: EdgeInsets.zero,
        duration: const Duration(seconds: 2),
        content: Material(
          color: AppColors.bg,
          shape: RoundedSuperellipseBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.grey),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: AppTypographyRoboto.regular17px.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: scaffoldMessenger.hideCurrentSnackBar,
                  child: const DraftlySvg(
                    assetName: SvgAsset.linearCloseCircle,
                    colorFilter: ColorFilter.mode(
                      AppColors.red,
                      BlendMode.srcIn,
                    ),
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
