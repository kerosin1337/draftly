import 'package:flutter/material.dart';

@immutable
class AppTypographyRoboto {
  static const String _fontFamily = 'Roboto';

  static const TextStyle regular17px = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 17,
    height: 24 / 17,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle regular15px = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 15,
    height: 20 / 17,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle regular14px = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    height: 24 / 14,
    fontWeight: FontWeight.w400,
  );
}

@immutable
class AppTypographyPressStart2P {
  static const String _fontFamily = 'PressStart2P';

  static const TextStyle regular20px = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 17,
    fontWeight: FontWeight.w400,
  );
}
