import 'dart:async';
import 'dart:io';

import 'package:konsole/konsole.dart';

class Konsole {
  List<KonsoleComponent> components = [];
  int _focusedIndex = 0;
  late Timer _timer;
  bool _needsFullRedraw = true;

  void add(KonsoleComponent component) => components.add(component);

  void _render() {
    if (_needsFullRedraw) {
      stdout.write(KonsoleAnsi.clear);
      _needsFullRedraw = false;
    }
    for (var component in components) {
      var lines = component.render().split('\n');
      for (int i = 0; i < lines.length; i++) {
        stdout.write(
          '\x1B[${component.marginVertical + i + 1};${component.marginHorizontal + 1}H',
        );

        stdout.write(lines[i]);
      }
    }
  }

  void forceRedraw() => _needsFullRedraw = true;

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
      if (input.startsWith('\x1B[M')) return;
      if (input == 'q') quit();
      if (input == '\t') _focusNext();
      for (var c in components) {
        c.handleInput(input);
      }
    });

    var focusable =
        components.expand((c) => c.getFocusableComponents()).toList();
    if (focusable.isNotEmpty) {
      _focusedIndex = 0;
      focusable[_focusedIndex].focused = true;
    }
    _render();
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

  void quit() {
    _timer.cancel();
    stdout.write(KonsoleAnsi.cursorShow);
    stdin.echoMode = true;
    stdin.lineMode = true;
    stdout.write(KonsoleAnsi.clear);
    exit(0);
  }
}
