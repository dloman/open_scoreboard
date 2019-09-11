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
              currentTimeSeconds: mGameTimeSeconds,
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
                  EditableMinutes(
                    label: 'Work',
                    currentMinutes: (workTimeSeconds ~/ 60).toString(),
                    addFunction: () {
                      updateWorkTime('add');
                    },
                    removeFunction: () {
                      updateWorkTime('remove');
                    },
                  ),
                  EditableMinutes(
                    label: 'Rest',
                    currentMinutes: (breakTimeSeconds ~/ 60).toString(),
                    addFunction: () {
                      updateBreakTime('add');
                    },
                    removeFunction: () {
                      updateBreakTime('remove');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
