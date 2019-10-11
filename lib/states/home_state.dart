import 'dart:async';
import 'dart:io';
import 'dart:convert';

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
    updateState(() {
      mIsRunning = true;
    });
    mGameTimer = new Timer.periodic(mTickDuration, _shotClockTick);
    mShotclockTimer = new Timer.periodic(mTickDuration, _gameClockTick);
  }

  @protected
  void stop() {
    updateState(() {
      mIsRunning = false;
    });
    mGameTimer.cancel();
    mShotclockTimer.cancel();
  }

  @protected
  void resetGameClock() {
    updateState(() {
      mCurrentGameTimeMilliseconds = mDefaultGameTimeMilliseconds;
    });
  }

  @protected
  void resetShotClock() {
    updateState(() {
      mCurrentShotclockTimeMilliseconds = mDefaultShotclockTimeMilliseconds;
    });
  }

  void _gameClockTick(Timer time) {
    if (mCurrentGameTimeMilliseconds > 0) {
      updateState(() {
        mCurrentGameTimeMilliseconds--;
      });
    }
    else {
      resetGameClock();
    }
  }


  void _shotClockTick(Timer time) {
    if (mCurrentShotclockTimeMilliseconds > 0) {
      updateState(() {
        mCurrentShotclockTimeMilliseconds--;
      });
    }
    else {
      resetShotClock();
    }
  }

  @protected
  void changeHomeScore(int Value) {
    updateState(() {
      mHomeScore += Value;
      if (mHomeScore < 0) {
        mHomeScore = 0;
      }
    });
  }

  @protected
  void changeAwayScore(int Value) {
    updateState(() {
      mAwayScore += Value;
      if (mAwayScore < 0) {
        mAwayScore = 0;
      }
    });
  }

  @protected
  void changeQuarter(int Value) {
    updateState(() {
      mQuarter += Value;
      if (mQuarter < 0) {
        mQuarter = 0;
      }
    });
  }

  @protected
  void resetHomeScore() {
    updateState( () {
      mHomeScore = 0;
    });
  }

  @protected
  void resetAwayScore() {
    updateState( () {
      mAwayScore = 0;
    });
  }
  @protected
  void resetQuarter() {
    updateState( () {
      mQuarter = 0;
    });
  }

  void updateState(Function function) {
    setState(function);

    RawDatagramSocket.bind(InternetAddress.anyIPv4, 42069).then((RawDatagramSocket udpSocket) {
        udpSocket.broadcastEnabled = true;

        List<int> data =utf8.encode('TEST');

        udpSocket.send(data, InternetAddress("255.255.255.255"), 42069);
      });
  }

}
