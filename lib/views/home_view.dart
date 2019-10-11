import 'package:flutter/material.dart';

import '../states/home_state.dart';
import '../components/shotclock.dart';
import '../components/gameClock.dart';
import '../components/clock_controls.dart';
import '../components/editable_number.dart';
import '../components/score_quarter.dart';
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
          ScoreQuarter(
            currentHomeScore: mHomeScore.toString(),
            currentAwayScore: mAwayScore.toString(),
            currentQuarter: mQuarter.toString(),
            addHomeFunction: () { changeHomeScore(1); },
            removeHomeFunction: () { changeHomeScore(-1); },
            resetHomeFunction: () { resetHomeScore(); },
            addAwayFunction: () { changeAwayScore(1); },
            removeAwayFunction: () { changeAwayScore(-1); },
            resetAwayFunction: () { resetAwayScore(); },
            addQuarterFunction: () { changeQuarter(1); },
            removeQuarterFunction: () { changeQuarter(-1); },
            resetQuarterFunction: () { resetQuarter(); },
          ),
        ],
      )
    );
  }

  Center _GetLandscape() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          EditableNumber(
            label: "Home",
            currentNumber: mHomeScore.toString().padLeft(2, "0"),
            addFunction: () { changeHomeScore(1); },
            removeFunction: () { changeHomeScore(-1); },
            resetFunction: () { resetHomeScore(); },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GameClockView(
                currentTimeMilliseconds: mCurrentGameTimeMilliseconds,
                running: mIsRunning,
                startFunction: start,
                stopFunction: stop,
                resetGameFunction: resetGameClock,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ShotClockView(
                    currentTimeMilliseconds: mCurrentShotclockTimeMilliseconds,
                    running: mIsRunning,
                    startFunction: start,
                    stopFunction: stop,
                    resetShotFunction: resetShotClock,
                  ),
                  EditableNumber(
                    label: "Quarter",
                    currentNumber: mQuarter.toString(),
                    addFunction: () { changeQuarter(1); },
                    removeFunction: () { changeQuarter(-1); },
                    resetFunction: () { resetQuarter(); },
                  ),
                ],
              ),
            ],
          ),
          EditableNumber(
            label: "Away",
            currentNumber: mAwayScore.toString().padLeft(2, "0"),
            addFunction: () { changeAwayScore(1); },
            removeFunction: () { changeAwayScore(-1); },
            resetFunction: () { resetAwayScore(); },
          ),
        ],
      )
    );
  }
}
