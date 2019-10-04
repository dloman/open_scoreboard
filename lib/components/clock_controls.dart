import 'package:flutter/material.dart';

import '../colors.dart';

class ClockControls extends StatelessWidget {
  final bool running;
  final Function startFunction;
  final Function stopFunction;
  final Function resetShotFunction;
  final Function resetGameFunction;

  ClockControls({
    this.running,
    this.startFunction,
    this.stopFunction,
    this.resetShotFunction,
    this.resetGameFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            onPressed: running ? stopFunction : startFunction,
            child: running ? Text('Stop') : Text('Start'),
            color: kOpenScoreboardBlue,
          ),
          RaisedButton(
            onPressed: resetShotFunction,
            child: Text('Reset Shot Clock'),
            color: kOpenScoreboardRedLight,
          ),
          RaisedButton(
            onPressed: resetGameFunction,
            child: Text('Reset Game Clock'),
            color: kOpenScoreboardRedLight,
          ),
        ],
      ),
    );
  }
}
