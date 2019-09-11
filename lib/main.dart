import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'theme.dart';
import 'screens/home_screen.dart';

void main() => runApp(OpenScoreboard());

class OpenScoreboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MaterialApp(
      title: 'OpenScoreboard',
      theme: kOpenScoreboardTheme,
      home: HomeScreen(),
    );
  }
}
