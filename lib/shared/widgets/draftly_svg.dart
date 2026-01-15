import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DraftlySvg extends StatelessWidget {
  final String assetName;
  final BoxFit fit;
  final double? width;
  final double? height;
  final AlignmentGeometry alignment;
  final ui.ColorFilter? colorFilter;

  const DraftlySvg({
    super.key,
    required this.assetName,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
    this.alignment = Alignment.center,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      colorFilter: colorFilter,
      // placeholderBuilder: (context) =>
      //     Skeleton(width: width ?? 24, height: height ?? 24, borderRadius: 8),
    );
  }
}
