import 'package:flutter/material.dart';

import '../colors.dart';

class GameClockView extends StatelessWidget {
  final int currentTimeMilliseconds;
  final bool running;
  final Function startFunction;
  final Function stopFunction;
  final Function resetGameFunction;

  GameClockView({
    this.currentTimeMilliseconds,
    this.running,
    this.startFunction,
    this.stopFunction,
    this.resetGameFunction,
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
              onLongPress: resetGameFunction,
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
}
