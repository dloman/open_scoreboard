import 'package:flutter/material.dart';

import '../states/home_state.dart';
import '../components/shotclock.dart';
import '../components/gameClock.dart';
import '../components/clock_controls.dart';
import '../components/editable_number.dart';
import '../components/status_text.dart';
import '../colors.dart';


class HomeView extends HomeState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOpenScoreboardGreyDark,
      body: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.portrait ? _GetPortrait() : _GetLandscape();
        }
      )
    );
  }

  Center _GetPortrait() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GameClockView(
            currentTimeMilliseconds: mCurrentGameTimeMilliseconds,
            running: mIsRunning,
            startFunction: start,
            stopFunction: stop,
            resetGameFunction: resetGameClock,
          ),
          ShotClockView(
            currentTimeMilliseconds: mCurrentShotclockTimeMilliseconds,
            running: mIsRunning,
            startFunction: start,
            stopFunction: stop,
            resetShotFunction: resetShotClock,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                EditableNumber(
                  label: 'Home',
                  currentNumber: mHomeScore.toString(),
                  addFunction: () {
                    changeHomeScore(1);
                  },
                  removeFunction: () {
                    changeHomeScore(-1);
                  },
                ),
                EditableNumber(
                  label: 'Quarter',
                  currentNumber: mQuarter.toString(),
                  addFunction: () {
                    changeQuarter(1);
                  },
                  removeFunction: () {
                    changeQuarter(-1);
                  },
                ),
                EditableNumber(
                  label: 'Away',
                  currentNumber: mAwayScore.toString(),
                  addFunction: () {
                    changeAwayScore(1);
                  },
                  removeFunction: () {
                    changeAwayScore(-1);
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Center _GetLandscape() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GameClockView(
            currentTimeMilliseconds: mCurrentGameTimeMilliseconds,
          ),
          ShotClockView(
            currentTimeMilliseconds: mCurrentShotclockTimeMilliseconds,
          ),
        ],
      )
    );
  }
}
