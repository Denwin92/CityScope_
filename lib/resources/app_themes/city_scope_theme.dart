import 'dart:ui';

import 'package:city_scope/resources/app_themes/city_scope_colours.dart';
import 'package:flutter/material.dart';

class CityScopeTheme{
  CityScopeTheme._();

  static TextStyle get textStyle => const TextStyle(color: Colors.black);
  static ThemeData get getMainAppThemeData => ThemeData(


    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'SpaceGrotesk',
    primarySwatch: CityScopeColours.primary,
    textTheme: TextTheme(

      bodyLarge: textStyle,
      bodyMedium: textStyle,
      bodySmall: textStyle,
      titleSmall: textStyle,
      titleMedium: textStyle,
      titleLarge: textStyle,
      displaySmall: textStyle,
      displayMedium: textStyle,
      displayLarge: textStyle,

    ),


  );


}