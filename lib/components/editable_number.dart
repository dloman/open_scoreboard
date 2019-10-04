import 'package:flutter/material.dart';

import '../colors.dart';

class EditableNumber extends StatelessWidget {
  final String label;
  final String currentNumber;
  final Function addFunction;
  final Function removeFunction;

  EditableNumber({
    this.label,
    this.currentNumber,
    this.addFunction,
    this.removeFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        color: kOpenScoreboardBlue,
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
            color: kOpenScoreboardBlueDark,
          ),
          Text("$currentNumber"),
          RaisedButton(
            child: Icon(Icons.remove),
            onPressed: removeFunction,
            color: kOpenScoreboardBlueDark,
          ),
        ],
      ),
    );
  }
}
