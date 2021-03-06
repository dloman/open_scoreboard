import 'package:flutter/material.dart';

import '../colors.dart';

class EditableNumber extends StatelessWidget {
  final String label;
  final String currentNumber;
  final Function addFunction;
  final Function removeFunction;
  final Function resetFunction;

  EditableNumber({
    this.label,
    this.currentNumber,
    this.addFunction,
    this.removeFunction,
    this.resetFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                          "+",
                          textAlign: TextAlign.center),
                      onPressed: addFunction,
                      textColor: Colors.white,
                      color: kOpenScoreboardGreyDarker,
                    ),
                    RaisedButton(
                      child: Text(
                          "-",
                          textAlign: TextAlign.center),
                      onPressed: removeFunction,
                      textColor: Colors.white,
                      color: kOpenScoreboardGreyDarker,
                    ),
                  ],
                ),
                flex: 3
                ),
              Spacer(flex:1),
              Flexible(
                child: Text(
                  currentNumber.toString().padLeft(2, '0'),
                  style: TextStyle(
                    fontSize: 55,
                    color: kOpenScoreboardBlue,
                  ),
                ),
                flex: 6,
                )
            ],
          ),
          RaisedButton(
            child: Text(
                "Reset",
                textAlign: TextAlign.center),
            onPressed: resetFunction,
            textColor: Colors.white,
            color: kOpenScoreboardGreyDarker,
          )
        ],
      ),
    );
  }
}
