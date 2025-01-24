import 'package:flutter/material.dart';

extension NavigatorExtension on BuildContext {
  void push(Widget screen) {
    Navigator.of(this).push(MaterialPageRoute(builder: (context) => screen));
  }

  void pushReplacement(Widget screen) {
    Navigator.of(this)
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }
}
