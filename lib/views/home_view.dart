import 'package:flutter/material.dart';

import '../states/home_state.dart';
import '../components/clock.dart';
import '../components/clock_controls.dart';
import '../components/editable_minutes.dart';
import '../components/status_text.dart';
import '../colors.dart';

class HomeView extends HomeState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOpenScoreboardGreenLight,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ClockView(
              currentTimeSeconds: mCurrentGameTimeMilliseconds,
            ),
            ClockControls(
              running: running,
              currentTimeSeconds: mGameTimeSeconds,
              startFunction: start,
              stopFunction: stop,
              resetFunction: reset,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(mCurrentGameTimeMilliseconds.toString()),
                  Text(mCurrentShotclockTimeMilliseconds.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
