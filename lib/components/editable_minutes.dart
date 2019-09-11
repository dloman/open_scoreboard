import 'package:flutter/material.dart';

import '../colors.dart';

class EditableMinutes extends StatelessWidget {
  final String label;
  final String currentMinutes;
  final Function addFunction;
  final Function removeFunction;

  EditableMinutes({
    this.label,
    this.currentMinutes,
    this.addFunction,
    this.removeFunction,
  });

  String _currentMinutesLabel() {
    if (currentMinutes == "1") {
      return "minute";
    } else {
      return "minutes";
    }
  }

  @override
  build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreen,
        borderRadius: BorderRadius.circular(2.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(fontSize: 20),
          ),
          RaisedButton(
            child: Icon(Icons.add),
            onPressed: addFunction,
            color: kOpenScoreboardGreenDark,
          ),
          Text("$currentMinutes ${_currentMinutesLabel()}"),
          RaisedButton(
            child: Icon(Icons.remove),
            onPressed: removeFunction,
            color: kOpenScoreboardGreenDark,
          ),
        ],
      ),
    );
  }
}
