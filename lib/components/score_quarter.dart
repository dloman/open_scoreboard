import 'package:flutter/material.dart';

import '../colors.dart';

class ScoreQuarter extends StatelessWidget {
  final String currentHomeScore;
  final String currentAwayScore;
  final String currentQuarter;
  final Function addHomeFunction;
  final Function removeHomeFunction;
  final Function resetHomeFunction;
  final Function addAwayFunction;
  final Function removeAwayFunction;
  final Function resetAwayFunction;
  final Function addQuarterFunction;
  final Function removeQuarterFunction;
  final Function resetQuarterFunction;

  ScoreQuarter({
    this.currentHomeScore,
    this.currentAwayScore,
    this.currentQuarter,
    this.addHomeFunction,
    this.removeHomeFunction,
    this.resetHomeFunction,
    this.addAwayFunction,
    this.removeAwayFunction,
    this.resetAwayFunction,
    this.addQuarterFunction,
    this.removeQuarterFunction,
    this.resetQuarterFunction,
  });

  @override
  build(BuildContext context) {
    return Container(
      width: 630,
      height: 200,
      decoration: BoxDecoration(
        color: kOpenScoreboardGreyDark,
        border: Border.all(
          color: kOpenScoreboardBlue,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getScore("Home", currentHomeScore, addHomeFunction, removeHomeFunction, resetHomeFunction),
            _getQuarter(),
            _getScore("Away", currentAwayScore, addAwayFunction, removeAwayFunction, resetAwayFunction),
          ],
        ),
    );
  }

  Column _getScore(String title, String value, Function add, Function remove, Function reset) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 5,
                    child: RaisedButton(
                      child: Text(
                          "+",
                          textAlign: TextAlign.center),
                      onPressed: add,
                      textColor: Colors.white,
                      color: kOpenScoreboardGreyDarker,
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 5,
                    child: RaisedButton(
                      child: Text(
                          "-",
                          textAlign: TextAlign.center),
                      onPressed: remove,
                      textColor: Colors.white,
                      color: kOpenScoreboardGreyDarker,
                    ),
                  ),
                ],
              ),
              Text(
                value.toString().padLeft(2, '0'),
                style: TextStyle(
                  fontSize: 55,
                  color: kOpenScoreboardBlue,
                ),
              ),
          ],
        ),
        RaisedButton(
          child: Text(
            "Reset Score",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          onPressed: reset,
          textColor: Colors.white,
          color: kOpenScoreboardGreyDarker,
        ),
      ],
    );
  }

  Container _getQuarter() {
    return Container(
      height: 150,
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
            "Quarter",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
          ),
          Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ButtonTheme(
                minWidth:5,
                child: ButtonTheme(
                  minWidth: 5,
                  child: RaisedButton(
                    child: Text(
                      "+",
                      textAlign: TextAlign.center),
                    onPressed: addQuarterFunction,
                    textColor: Colors.white,
                    color: kOpenScoreboardGreyDarker,
                  ),
                ),
              ),
              GestureDetector(
                onLongPress: addQuarterFunction,
                child: Text(
                  currentQuarter,
                  style: TextStyle(
                    fontSize: 40,
                    color: kOpenScoreboardBlue,
                  ),
                ),
              ),

              ButtonTheme(
                minWidth: 5,
                child: ButtonTheme(
                  minWidth: 5,
                  child: RaisedButton(
                    child: Text(
                      "-",
                      textAlign: TextAlign.center
                      ),
                    onPressed: removeQuarterFunction,
                    textColor: Colors.white,
                    color: kOpenScoreboardGreyDarker,
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
            child: Text(
              "Reset",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: resetQuarterFunction,
            textColor: Colors.white,
            color: kOpenScoreboardGreyDarker,
          ),
        ],
      ),
    );
  }

}
