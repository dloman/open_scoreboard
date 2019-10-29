import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_picker/flutter_picker.dart';


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

  void _showNumberPicker(BuildContext context) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: 8),
          NumberPickerColumn(begin: 0, end: 59),
        ]),
        backgroundColor: kOpenScoreboardGreyDark,
        headercolor: kOpenScoreboardGreyDark,
        containerColor: kOpenScoreboardGreyDark,
        delimiter: [
          PickerDelimiter(child: Container(
            width: 30.0,
            alignment: Alignment.center,
            child: Icon(Icons.more_vert),
          ))
        ],
        hideHeader: true,
        title: new Text("Set Current Game Clock Value", style: TextStyle(color: kOpenScoreboardBlue)),
        textStyle: TextStyle(color: kOpenScoreboardBlue),
        cancelTextStyle: TextStyle(color: kOpenScoreboardBlue),
        confirmTextStyle: TextStyle(color: kOpenScoreboardBlue),
        onConfirm: (Picker picker, List value) {
          setGameFunction((value[0] * 60 * 1000) + value[1] * 1000);
        }
    ).showDialog(context, kOpenScoreboardGreyDark);
  }
}
