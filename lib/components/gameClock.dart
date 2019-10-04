import 'package:flutter/material.dart';

import '../colors.dart';

class GameClockView extends StatelessWidget {
  final int currentTimeMilliseconds;

  GameClockView({
    this.currentTimeMilliseconds,
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
      height: 150,
      width: 350,
      decoration: BoxDecoration(
        color: kOpenScoreboardBlue,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: kOpenScoreboardBlueDark,
          width: 3,
        ),
      ),
      child: Center(
        child: Text(
          _stringTime(),
          style: TextStyle(
            fontSize: 80,
          ),
        ),
      ),
    );
  }
}
