import 'package:flutter/material.dart';

import '../colors.dart';
import 'package:flutter/services.dart';

class ShotClockView extends StatelessWidget {
  final int currentTimeMilliseconds;
  final int defaultShotclock;
  final bool running;
  final Function startFunction;
  final Function stopFunction;
  final Function resetShotFunction;
  final Function setShotFunction;
  final Function setDefaultShotFunction;
  TextEditingController _controller = TextEditingController();

  ShotClockView({
    this.currentTimeMilliseconds,
    this.defaultShotclock,
    this.running,
    this.startFunction,
    this.stopFunction,
    this.resetShotFunction,
    this.setShotFunction,
    this.setDefaultShotFunction,
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
              onLongPress: () { _showNumberPicker(
                  context,
                  "Current",
                  defaultShotclock,
                  (int value) { setShotFunction(value); },);},
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
                  onLongPress: () { _showNumberPicker(
                      context,
                      "Default",
                      99,
                      (int value) { setDefaultShotFunction(value); },
                      ); },
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

  _showNumberPicker (BuildContext context, String display, int max, onConfirm) async  {
    await showDialog<int>(
      context: context,
      child: new AlertDialog(
        content: new Row(
          children: <Widget>[
            new Expanded(
              child: new TextField(
                style: TextStyle(color: kOpenScoreboardBlue),
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: "Set " + display +" Shotclock Value [0-" + max.toString()+"]"
                ),
                controller: _controller,
              ),
            )
          ],
        ),
        actions: <Widget>[
          new FlatButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              }),
          new FlatButton(
              child: const Text('Confirm'),
              onPressed: () {
                  try {
                    int value = (int.parse(_controller.text));

                    if (value > 0 && value < max) {
                      onConfirm(value * 1000);
                      Navigator.pop(context);
                    }
                  }
                  catch(e) {
                    print(e);
                  }
              })
        ],
      ),
    );
  }

}
