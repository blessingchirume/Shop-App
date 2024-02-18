import 'package:flutter/material.dart';

ThemeData formulaLightTheme() {
  const formulaPrimaryColor = Color(0xFF008ED3);
  const formulaSecondaryColor = Color(0xFFFFA800);

  return ThemeData(
    iconTheme: IconThemeData(color: formulaSecondaryColor.withOpacity(.5)),
    primaryColor: formulaPrimaryColor,
    scaffoldBackgroundColor: const Color(0xFFF1F1F1),
    appBarTheme: const AppBarTheme(backgroundColor: formulaPrimaryColor),
    backgroundColor: formulaPrimaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(secondary: formulaSecondaryColor.withOpacity(.5)),
  );
}
