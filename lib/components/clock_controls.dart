import 'package:flutter/material.dart';

import '../colors.dart';

class ClockControls extends StatelessWidget {
  final bool running;
  final int currentTimeSeconds;
  final Function startFunction;
  final Function stopFunction;
  final Function resetFunction;

  ClockControls({
    this.running,
    this.currentTimeSeconds,
    this.startFunction,
    this.stopFunction,
    this.resetFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          RaisedButton(
            onPressed: running ? null : startFunction,
            child: Text('Start'),
            color: kOpenScoreboardGreen,
          ),
          RaisedButton(
            onPressed: running ? stopFunction : null,
            child: Text('Stop'),
            color: kOpenScoreboardRedLight,
          ),
          RaisedButton(
            onPressed: running ? null : resetFunction,
            child: Text('Reset'),
            color: kOpenScoreboardGreen,
          ),
        ],
      ),
    );
  }
}
