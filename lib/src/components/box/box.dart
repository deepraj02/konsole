import 'package:konsole/konsole.dart';

class Box extends KonsoleComponent {
  KonsoleComponent child;
  String? title;
  String fgColor;
  String? bgColor;

  Box(
    this.child, {
    this.title,
    this.fgColor = AnsiColors.white,
    this.bgColor,
    super.x,
    super.y,
  }) : super(width: child.width + 2, height: child.height + 2) {
    child.x = x + 1;
    child.y = y + 1;
  }

  @override
  String render() {
    String top = '┌${(title ?? '─' * (width - 2)).padRight(width - 2, '─')}┐';
    if (title != null && title!.length > width - 2) {
      top = '┌${title!.substring(0, width - 2)}┐';
    }
    List<String> childLines = child.render().split('\n');
    List<String> middleLines = [];
    for (int i = 0; i < height - 2; i++) {
      String line = i < childLines.length ? childLines[i] : '';
      if (line.length > width - 2) line = line.substring(0, width - 2);
      middleLines.add('│${line.padRight(width - 2)}│');
    }
    String bottom = '└${'─' * (width - 2)}┘';
    return Ansi.color(
      [top, ...middleLines, bottom].join('\n'),
      fg: fgColor,
      bgColor: bgColor,
    );
  }

  @override
  void update(double dt) => child.update(dt);

  @override
  void handleInput(String input) {
    child.handleInput(input);
  }

  @override
  List<KonsoleComponent> getFocusableComponents() {
    return child.getFocusableComponents();
  }
}
