import 'dart:convert';

import 'package:flutter/material.dart';

import '/shared/constants/asset_paths.dart' show SvgAsset;
import '/shared/widgets/draftly_svg.dart';

class DraftlyImage extends StatelessWidget {
  final String image;

  const DraftlyImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      base64Decode(image),
      fit: BoxFit.cover,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame == null) {
          return const CircularProgressIndicator(value: 0.01);
        }
        return child;
      },
      errorBuilder: (context, error, stackTrace) {
        return const DraftlySvg(
          assetName: SvgAsset.boldCloseCircle,
          width: 24,
          height: 24,
        );
      },
    );
  }
}
