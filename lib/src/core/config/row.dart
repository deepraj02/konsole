import 'dart:math';

import 'package:konsole/src/core/config/component_interface.dart';

class Row extends KonsoleComponent {
  List<KonsoleComponent> children;

  Row(this.children, {super.marginHorizontal, super.marginVertical})
    : super(width: 0, height: 0) {
    int totalWidth = 0;
    int maxHeight = 0;
    for (var child in children) {
      child.marginHorizontal = marginHorizontal + totalWidth;
      totalWidth += child.width;
      maxHeight = max(maxHeight, child.height);
    }
    width = totalWidth;
    height = maxHeight;
  }

  @override
  String render() {
    List<List<String>> childLines =
        children.map((c) => c.render().split('\n')).toList();
    int maxLines = childLines.map((lines) => lines.length).reduce(max);
    List<String> rowLines = [];
    for (int i = 0; i < maxLines; i++) {
      String line =
          childLines
              .map(
                (lines) =>
                    i < lines.length
                        ? lines[i].padRight(
                          children[childLines.indexOf(lines)].width,
                        )
                        : ' ' * children[childLines.indexOf(lines)].width,
              )
              .join();
      rowLines.add(line);
    }
    return rowLines.join('\n');
  }

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
