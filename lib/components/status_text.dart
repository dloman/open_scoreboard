import 'package:flutter/material.dart';

class StatusText extends StatelessWidget {
  final bool working;
  final bool running;

  StatusText({
    this.working,
    this.running,
  });

  String _status() {
    String status = "";

    if (running) {
      if (working) {
        status = "Working";
      } else {
        status = "Resting";
      }
    } else {
      status = 'Paused';
    }

    return status;
  }

  @override
  build(BuildContext context) {
    return Text(
      _status(),
      style: TextStyle(
        fontSize: 50,
      ),
    );
  }
}
