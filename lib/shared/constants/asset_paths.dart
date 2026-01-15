import 'package:flutter/material.dart';

class ImageAsset {
  static const _basePath = 'assets/images';

  static const background = AssetImage('$_basePath/background.png');
  static const backgroundPattern = AssetImage(
    '$_basePath/background_pattern.png',
  );
}

class SvgAsset {
  static const _basePath = 'assets/icons';

  static const linearCloseCircle = '$_basePath/linear/close-circle.svg';
  static const linearDownload = '$_basePath/linear/download.svg';

  static const boldGallery = '$_basePath/bold/gallery.svg';
  static const boldEdit = '$_basePath/bold/edit.svg';
  static const boldErase = '$_basePath/bold/erase.svg';
  static const boldPalette = '$_basePath/bold/palette.svg';
}
