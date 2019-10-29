import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';

import '../screens/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  @protected
  Timer mGameTimer;
  Timer mShotclockTimer;
  Timer mRefreshTimer;

  RawDatagramSocket mSocket;

  Duration mTickDuration = new Duration(milliseconds: 1);
  Duration mRefreshTickDuration = new Duration(seconds: 1);

  int mDefaultGameTimeMilliseconds = 8 * 60 * 1000;
  int mDefaultShotclockTimeMilliseconds = 35 * 1000;
  int mTimeSeconds = 300; // 5 minutes
  int mCurrentGameTimeMilliseconds = 0;
  int mCurrentShotclockTimeMilliseconds = 0;
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

    mGameTimer = new Timer.periodic(mTickDuration, _shotClockTick);
    mShotclockTimer = new Timer.periodic(mTickDuration, _gameClockTick);
    mRefreshTimer = new Timer.periodic(mRefreshTickDuration, _refreshTick);

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
  }

  @protected
  void stop() {
    updateState(() {
      mIsRunning = false;
    });
    mGameTimer.cancel();
    mShotclockTimer.cancel();
    mRefreshTimer.cancel();
  }

  @protected
  void resetGameClock() {
    updateState(() {
      mCurrentGameTimeMilliseconds = mDefaultGameTimeMilliseconds;
    });
  }

  @protected
  void setGameClock(int value) {
    updateState(() {
      mCurrentGameTimeMilliseconds = value;
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
    });
  }

  @protected
  void setShotClock(int value) {
    updateState(() {
      mCurrentShotclockTimeMilliseconds = value;
    });
  }

  void _gameClockTick(Timer time) {
    if (mCurrentGameTimeMilliseconds > 0) {
      mCurrentGameTimeMilliseconds--;
    }
  }

  void _shotClockTick(Timer time) {
    if (mCurrentShotclockTimeMilliseconds > 0) {
      mCurrentShotclockTimeMilliseconds--;
    }
  }

  void _refreshTick(Timer time) {
    updateState(() {});
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
      });
  }
}
