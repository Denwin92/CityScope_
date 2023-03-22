import 'package:flutter/material.dart';

class CityScopeColours {

  CityScopeColours._();

  static const _primaryColourValue = 0xFF053368;

      static const MaterialColor primary = MaterialColor(
    _primaryColourValue,
    <int, Color>{
      50: Color(0xFFE1E7EE),
      100: Color(0xFFB4C4D4),
      200: Color(0xFF839CB8),
      300: Color(0xFF51749B),
      400: Color(0xFF2B5785),
      500: Color(_primaryColourValue),
      600: Color(0xFF053368),
      700: Color(0xFF042C5D),
      800: Color(0xFF032453),
      900: Color(0xFF021741),
    },
  );



}