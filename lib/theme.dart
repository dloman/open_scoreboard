import 'package:flutter/material.dart';

import 'colors.dart';

final ThemeData kOpenScoreboardTheme = _buildOpenScoreboardTheme();

ThemeData _buildOpenScoreboardTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: kOpenScoreboardRedLight,
    primaryColor: kOpenScoreboardBlueLight,
    scaffoldBackgroundColor: kOpenScoreboardGreyDark,
  );
}
