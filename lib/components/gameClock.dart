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
  final Function setDefaultGameFunction;

  GameClockView({
    this.currentTimeMilliseconds,
    this.defaultGameclock,
    this.running,
    this.startFunction,
    this.stopFunction,
    this.resetGameFunction,
    this.setGameFunction,
    this.setDefaultGameFunction
  });

  String _stringTime() {
    var minutesString = _getMinutes(currentTimeMilliseconds).toString().padLeft(2, '0');

    var secondsString = _getSeconds(currentTimeMilliseconds).toString().padLeft(2, '0');

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
              onLongPress: () {
                _showNumberPicker(
                    context,
                    "Current",
                    (defaultGameclock ~/ (60 * 1000)),
                    _getMinutes(currentTimeMilliseconds),
                    _getSeconds(currentTimeMilliseconds),
                    (Picker picker, List value) {
                      setGameFunction((value[0] * 60 * 1000) + value[1] * 1000);
                    });
              },
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
                  onLongPress: () {
                    _showNumberPicker(
                        context,
                        "Default",
                        99,
                        _getMinutes(defaultGameclock),
                        _getSeconds(defaultGameclock),
                        (Picker picker, List value) {
                          setDefaultGameFunction((value[0] * 60 * 1000) + value[1] * 1000);
                        });
                  },
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

  int _getMinutes(int milliseconds) {
    return (milliseconds ~/ (60 * 1000));
  }

  int _getSeconds (int milliseconds) {
    return (milliseconds - (_getMinutes(milliseconds) * 60 * 1000)) ~/ 1000;
  }

  void _showNumberPicker(
      BuildContext context,
      String display,
      int end,
      int currentMinutes,
      int currentSeconds,
      Function onConfirm) {
    new Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: end, initValue: currentMinutes),
          NumberPickerColumn(begin: 0, end: 59, initValue: currentSeconds),
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
        title: new Text("Set "+ display +" Game Clock Value", style: TextStyle(color: kOpenScoreboardBlue)),
        textStyle: TextStyle(color: kOpenScoreboardBlue),
        cancelTextStyle: TextStyle(color: kOpenScoreboardBlue),
        confirmTextStyle: TextStyle(color: kOpenScoreboardBlue),
        onConfirm: onConfirm
    ).showDialog(context, kOpenScoreboardGreyDark);
  }
}
