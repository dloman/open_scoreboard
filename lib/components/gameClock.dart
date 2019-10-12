import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:flutter/cupertino.dart';


class GameClockView extends StatelessWidget {
  final int currentTimeMilliseconds;
  final int defaultGameclock;
  final bool running;
  final Function startFunction;
  final Function stopFunction;
  final Function resetGameFunction;
  final Function setGameFunction;

  GameClockView({
    this.currentTimeMilliseconds,
    this.defaultGameclock,
    this.running,
    this.startFunction,
    this.stopFunction,
    this.resetGameFunction,
    this.setGameFunction,
  });

  String _stringTime() {
    var minutes = (currentTimeMilliseconds ~/ (60 * 1000));
    var minutesString = minutes.toString().padLeft(2, '0');

    var seconds = (currentTimeMilliseconds - (minutes * 60 * 1000)) ~/ 1000;
    var secondsString = seconds.toString().padLeft(2, '0');

    return "$minutesString:$secondsString";
  }

  @override
  build(BuildContext context) {
    return Container(
      height: 200,
      width: 280,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "Game Clock",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onLongPress: () { _showNumberPicker(context); },
              child: Text(
                  _stringTime(),
                  style: TextStyle(
                      fontSize: 80,
                      color: kOpenScoreboardBlue,
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: running ? stopFunction : startFunction,
                  textColor: Colors.white,
                  child: running ? Text('Stop') : Text('Start'),
                  color: kOpenScoreboardGreyDarker,
                ),
                RaisedButton(
                  onPressed: resetGameFunction,
                  textColor: Colors.white,
                  child: Text('Reset Game Clock'),
                  color: kOpenScoreboardGreyDarker,
                ),
              ]
            ),
          ],
        ),
      )
    );
  }

  Future _showNumberPicker(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.ms,
            initialTimerDuration: Duration(seconds: 100),
            minuteInterval: 1,
            secondInterval: 1,
            onTimerDurationChanged: (Duration newTimer) {
            },
        );
      }
    );
  }
}
