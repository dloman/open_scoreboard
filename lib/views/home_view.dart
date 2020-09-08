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
      resizeToAvoidBottomPadding:false,
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
            defaultGameclock: mDefaultGameTimeMilliseconds,
            running: mIsRunning,
            startFunction: start,
            stopFunction: stop,
            resetGameFunction: resetGameClock,
            setGameFunction: setGameClock,
            setDefaultGameFunction: setDefaultGameClock,
          ),
          ShotClockView(
            currentTimeMilliseconds: mCurrentShotclockTimeMilliseconds,
            defaultShotclock: mDefaultShotclockTimeMilliseconds ~/ 1000,
            running: mIsRunning,
            startFunction: start,
            stopFunction: stop,
            resetShotFunction: resetShotClock,
            setShotFunction: setShotClock,
            setDefaultShotFunction: setDefaultShotClock,
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
                defaultGameclock: mDefaultGameTimeMilliseconds,
                running: mIsRunning,
                startFunction: start,
                stopFunction: stop,
                resetGameFunction: resetGameClock,
                setGameFunction: setGameClock,
                setDefaultGameFunction: setDefaultGameClock,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ShotClockView(
                    currentTimeMilliseconds: mCurrentShotclockTimeMilliseconds,
                    defaultShotclock: mDefaultShotclockTimeMilliseconds,
                    running: mIsRunning,
                    startFunction: start,
                    stopFunction: stop,
                    resetShotFunction: resetShotClock,
                    setShotFunction: setShotClock,
                    setDefaultShotFunction: setDefaultShotClock,
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

  void _showWifiDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Alert Dialog title"),
            content: new Text("Alert Dialog body"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
}
