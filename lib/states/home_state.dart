import 'dart:async';

import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  @protected
  Timer mGameTimer;
  Timer mShotclockTimer;
  Duration mTickDuration = new Duration(milliseconds: 1);
  int mDefaultGameTimeMilliseconds = 8 * 60 * 1000;
  int mDefaultShotclockTimeMilliseconds = 35 * 1000;
  int mTimeSeconds = 300; // 5 minutes
  int mCurrentGameTimeMilliseconds = 0;
  int mCurrentShotclockTimeMilliseconds = 0;
  bool mIsRunning = false;
  int mHomeScore = 0;
  int mAwayScore = 0;
  int mQuarter = 0;

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @protected
  void start() {
    setState(() {
      mIsRunning = true;
    });
    mGameTimer = new Timer.periodic(mTickDuration, _shotClockTick);
    mShotclockTimer = new Timer.periodic(mTickDuration, _gameClockTick);
  }

  @protected
  void stop() {
    setState(() {
      mIsRunning = false;
    });
    mGameTimer.cancel();
    mShotclockTimer.cancel();
  }

  @protected
  void resetGameClock() {
    setState(() {
      mCurrentGameTimeMilliseconds = mDefaultGameTimeMilliseconds;
    });
  }

  @protected
  void resetShotClock() {
    setState(() {
      mCurrentShotclockTimeMilliseconds = mDefaultShotclockTimeMilliseconds;
    });
  }

  void _gameClockTick(Timer time) {
    if (mCurrentGameTimeMilliseconds > 0) {
      setState(() {
        mCurrentGameTimeMilliseconds--;
      });
    }
  }


  void _shotClockTick(Timer time) {
    if (mCurrentShotclockTimeMilliseconds > 0) {
      setState(() {
        mCurrentShotclockTimeMilliseconds--;
      });
    }
  }

  @protected
  void changeHomeScore(int Value) {
    mHomeScore += Value;
    if (mHomeScore < 0) {
      mHomeScore = 0;
    }
  }

  @protected
  void changeAwayScore(int Value) {
    mAwayScore += Value;
    if (mAwayScore < 0) {
      mAwayScore = 0;
    }
  }

  @protected
  void changeQuarter(int Value) {
    mQuarter += Value;
    if (mQuarter < 0) {
      mQuarter = 0;
    }

  }
}
