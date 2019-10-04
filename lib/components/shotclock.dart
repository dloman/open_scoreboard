import 'package:flutter/material.dart';

import '../colors.dart';

class ShotClockView extends StatelessWidget {
  final int currentTimeMilliseconds;

  ShotClockView({
    this.currentTimeMilliseconds,
  });

  String _stringTime() {
    var seconds = (currentTimeMilliseconds ~/ 1000);
    var secondsString = seconds.toString().padLeft(2, '0');

    return "$secondsString";
  }

  @override
  build(BuildContext context) {
    return Container(
      height: 150,
      width: 250,
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
