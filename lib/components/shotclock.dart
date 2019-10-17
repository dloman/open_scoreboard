import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:flutter_picker/flutter_picker.dart';

class ShotClockView extends StatelessWidget {
  final int currentTimeMilliseconds;
  final int defaultShotclock;
  final bool running;
  final Function startFunction;
  final Function stopFunction;
  final Function resetShotFunction;
  final Function setShotFunction;

  ShotClockView({
    this.currentTimeMilliseconds,
    this.defaultShotclock,
    this.running,
    this.startFunction,
    this.stopFunction,
    this.resetShotFunction,
    this.setShotFunction,
  });

  String _stringTime() {
    var seconds = (currentTimeMilliseconds ~/ 1000);
    var secondsString = seconds.toString().padLeft(2, '0');

    return "$secondsString";
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
              "Shot Clock",
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
                  onPressed: resetShotFunction,
                  textColor: Colors.white,
                  child: Text('Reset Shotclock'),
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
    Picker(
        adapter: NumberPickerAdapter(data: [
          NumberPickerColumn(begin: 0, end: defaultShotclock)),
        ]),
        hideHeader: true,
        title: Text("Select Shotclock Value"),
        selectedTextStyle: TextStyle(color: Colors.white),
        backgroundColor: kOpenScoreboardGreyDark,
        onConfirm: (Picker picker, List value) {
          print(value.toString());
          print(picker.getSelectedValues());
        }
    ).showDialog(context);
  }
}
