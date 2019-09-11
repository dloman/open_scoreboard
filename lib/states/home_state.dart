import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  @protected
  Timer mTimer;
  Duration mTickDuration = new Duration(milliseconds: 1);
  int mGameTimeSeconds = 1500; // 25 minutes
  int mTimeSeconds = 300; // 5 minutes
  int mCurrentTimeSeconds = 1500;
  bool running = false;
  bool working = true;

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @protected
  void start() {
    setState(() {
      running = true;
    });
    timer = new Timer.periodic(tickDuration, _tick);
  }

  @protected
  void stop() {
    setState(() {
      running = false;
    });
    timer.cancel();
  }

  @protected
  void reset() {
    setState(() {
      currentTimeSeconds = workTimeSeconds;
      working = true;
    });
  }

  @protected
  void updateWorkTime(String action) {
    int seconds = _secondsForTimeUpdate(action);

    if (_addableTime(action, workTimeSeconds) ||
        _removableTime(action, workTimeSeconds)) {
      setState(() {
        workTimeSeconds = workTimeSeconds + seconds;
      });
    }
  }

  @protected
  void updateBreakTime(String action) {
    int seconds = _secondsForTimeUpdate(action);

    if (_addableTime(action, breakTimeSeconds) ||
        _removableTime(action, breakTimeSeconds)) {
      setState(() {
        breakTimeSeconds = breakTimeSeconds + seconds;
      });
    }
  }

  void _tick(Timer time) {
    if (currentTimeSeconds <= 0) {
      setState(() {
        currentTimeSeconds = working ? breakTimeSeconds : workTimeSeconds;
        working = !working;
      });
    } else {
      setState(() {
        currentTimeSeconds--;
      });
    }
  }

  int _secondsForTimeUpdate(String action) {
    switch (action) {
      case ('add'):
        return 60;
        break;
      case ('remove'):
        return -60;
        break;
      default:
        throw ArgumentError;
    }
  }

  bool _addableTime(String action, int timeSeconds) {
    int timeMinutes = timeSeconds ~/ 60;

    return action == 'add' && timeMinutes <= 58;
  }

  bool _removableTime(String action, int timeSeconds) {
    int timeMinutes = timeSeconds ~/ 60;

    return action == 'remove' && timeMinutes >= 2;
  }
}
