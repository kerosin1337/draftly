import 'package:flutter/material.dart';

import '/core/theme/app_colors.dart';
import '/shared/widgets/draftly_svg.dart';

class DraftlyIconButton extends StatelessWidget {
  final String assetName;

  final VoidCallback onPressed;

  const DraftlyIconButton({
    super.key,
    required this.assetName,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.greyDark,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          padding: const EdgeInsets.all(8),
          child: DraftlySvg(
            assetName: assetName,
            width: 22,
            height: 22,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
