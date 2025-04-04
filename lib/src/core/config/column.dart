import 'dart:math';

import 'package:konsole/src/core/config/component_interface.dart';

class Column extends KonsoleComponent {
  List<KonsoleComponent> children;

  Column(this.children, {super.marginHorizontal, super.marginVertical})
    : super(width: 0, height: 0) {
    int totalHeight = 0;
    int maxWidth = 0;
    for (var child in children) {
      child.marginVertical = marginVertical + totalHeight;
      totalHeight += child.height;
      maxWidth = max(maxWidth, child.width);
    }
    width = maxWidth;
    height = totalHeight;
  }

  @override
  String render() => children.map((c) => c.render()).join('\n');

  @override
  void update(double dt) {
    for (var child in children) {
      child.update(dt);
    }
  }

  @override
  void handleInput(String input) {
    for (var child in children) {
      child.handleInput(input);
    }
  }

  @override
  List<KonsoleComponent> getFocusableComponents() {
    return children.expand((c) => c.getFocusableComponents()).toList();
  }
}
