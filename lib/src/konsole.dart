import 'dart:async';
import 'dart:io';

import 'package:konsole/konsole.dart';

class Konsole {
  List<KonsoleComponent> components = [];
  int _focusedIndex = 0;
  late Timer _timer;

  void add(KonsoleComponent component) => components.add(component);

  void _render() {
    stdout.write(KonsoleAnsi.clear);
    for (var component in components) {
      var lines = component.render().split('\n');
      for (int i = 0; i < lines.length; i++) {
        stdout.write(
          '\x1B[${component.y + i + 1};${component.x + 1}H${lines[i]}',
        );
      }
    }
  }

  void run() {
    stdin.echoMode = false;
    stdin.lineMode = false;
    stdout.write(KonsoleAnsi.cursorHide);

    _timer = Timer.periodic(Duration(milliseconds: 16), (timer) {
      for (var c in components) {
        c.update(0.016);
      }
      _render();
    });

    stdin.listen((data) {
      String input = String.fromCharCodes(data);
      if (input == 'q') _quit();
      if (input == '\t') _focusNext();
      for (var c in components) {
        c.handleInput(input);
      }
      _render();
    });

    var focusable =
        components.expand((c) => c.getFocusableComponents()).toList();
    if (focusable.isNotEmpty) {
      _focusedIndex = 0;
      focusable[_focusedIndex].focused = true;
    }
  }

  void _focusNext() {
    var focusable =
        components.expand((c) => c.getFocusableComponents()).toList();
    if (focusable.isNotEmpty) {
      focusable[_focusedIndex].focused = false;
      _focusedIndex = (_focusedIndex + 1) % focusable.length;
      focusable[_focusedIndex].focused = true;
    }
  }

  void _quit() {
    _timer.cancel();
    stdout.write(KonsoleAnsi.cursorShow);
    stdin.echoMode = true;
    stdin.lineMode = true;
    stdout.write(KonsoleAnsi.clear);
    exit(0);
  }
}
