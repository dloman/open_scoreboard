import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../screens/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  @protected
  Stopwatch mGameStopwatch = new Stopwatch();
  Stopwatch mShotclockStopwatch = new Stopwatch();
  Timer mRefreshTimer;

  Duration mRefreshTickDuration = new Duration(milliseconds: 30);

  int mDefaultGameTimeMilliseconds = 8 * 60 * 1000;
  int mDefaultShotclockTimeMilliseconds = 35 * 1000;
  int mTimeSeconds = 300; // 5 minutes
  int mCurrentGameTimeMilliseconds = 0;
  int mCurrentShotclockTimeMilliseconds = 0;
  int mAdditionalGameTimeMilliseconds = 0;
  int mAdditionalShotclockMilliseconds = 0;
  int mHomeScore = 0;
  int mAwayScore = 0;
  int mQuarter = 0;

  bool mIsRunning = false;

  @override
  void dispose() {
    stop();
    super.dispose();
  }

  @protected
  void start() {

    mRefreshTimer = new Timer.periodic(mRefreshTickDuration, _refreshTick);
    mGameStopwatch.start();
    mShotclockStopwatch.start();

    updateState(() {
      mIsRunning = true;

      if (mCurrentGameTimeMilliseconds <= 0)
      {
        resetGameClock();
      }

      if (mCurrentShotclockTimeMilliseconds <= 0)
      {
        resetShotClock();
      }
    });
    HapticFeedback.selectionClick();
  }

  @protected
  void stop() {
    updateState(() {
      mIsRunning = false;
    });
    mGameStopwatch.stop();
    mShotclockStopwatch.stop();
    HapticFeedback.selectionClick();
  }

  @protected
  void resetGameClock() {
    updateState(() {
      mGameStopwatch = new Stopwatch();

      if (mIsRunning) {
        mGameStopwatch.start();
      }

      mAdditionalGameTimeMilliseconds = 0;
    });
  }

  @protected
  void setGameClock(int value) {
    updateState(() {
      resetGameClock();

      mAdditionalGameTimeMilliseconds = mDefaultGameTimeMilliseconds - value;

      updateTime();
    });
  }

  @protected
  void setDefaultGameClock(int value) {
    updateState(() {

      mDefaultGameTimeMilliseconds = value;

      resetGameClock();

      updateTime();
    });
  }

  @protected
  void resetShotClock() {
    updateState(() {

      if (
          mCurrentGameTimeMilliseconds <= mDefaultShotclockTimeMilliseconds &&
          mCurrentGameTimeMilliseconds != 0)
      {
        mCurrentShotclockTimeMilliseconds = mCurrentGameTimeMilliseconds;
      }
      else
      {
        mCurrentShotclockTimeMilliseconds = mDefaultShotclockTimeMilliseconds;
      }

      mShotclockStopwatch = new Stopwatch();

      mAdditionalShotclockMilliseconds = 0;

      if (mIsRunning) {
        mShotclockStopwatch.start();
      }
    });
    HapticFeedback.heavyImpact();
  }

  @protected
  void setShotClock(int value) {
    updateState(() {

      resetShotClock();

      mAdditionalShotclockMilliseconds = mDefaultShotclockTimeMilliseconds - value;

      updateTime();
    });
  }

  @protected
  void setDefaultShotClock(int value) {
    print("we here");
    updateState(() {
      mDefaultShotclockTimeMilliseconds = value;

      resetShotClock();

      updateTime();
    });
  }

  void updateTime() {
    mCurrentGameTimeMilliseconds =
      mDefaultGameTimeMilliseconds - (mGameStopwatch.elapsedMilliseconds + mAdditionalGameTimeMilliseconds);

    if (mCurrentGameTimeMilliseconds < 0) {
      mCurrentGameTimeMilliseconds = 0;
    }

    mCurrentShotclockTimeMilliseconds =
      mDefaultShotclockTimeMilliseconds - (mShotclockStopwatch.elapsedMilliseconds + mAdditionalShotclockMilliseconds);

    if (mCurrentShotclockTimeMilliseconds < 0) {
      mCurrentShotclockTimeMilliseconds = 0;
    }

  }

  void _refreshTick(Timer time) {
    updateState(() {updateTime();});
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

        int Minutes = mCurrentGameTimeMilliseconds ~/ (60 * 1000);
        int Seconds = (mCurrentGameTimeMilliseconds - (Minutes * 60 * 1000)) ~/ 1000;

        String ScorePacket =
          mHomeScore.toString() + "," +
          mAwayScore.toString() + "," +
          Minutes.toString() + "," +
          Seconds.toString();

        udpSocket.send(utf8.encode(ScorePacket), InternetAddress("255.255.255.255"), 33333);

        udpSocket.send(
          utf8.encode((mCurrentShotclockTimeMilliseconds ~/ 1000).toString().padLeft(2,"0")),
          InternetAddress("255.255.255.255"),
          11111);

        udpSocket.close();
      });
  }
}
