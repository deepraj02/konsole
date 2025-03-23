import 'package:konsole/konsole.dart';

class Counter extends KonsoleComponent {
  int value;
  String fgColor;
  String? bgColor;
  int totalWidth;

  Counter({
    this.value = 0,
    this.fgColor = KonsoleColors.white,
    this.bgColor,
    this.totalWidth = 20,
    super.x,
    super.y,
  }) : super(width: totalWidth, height: 1) {
    focusable = true;
  }

  @override
  String render() {
    String text = 'Counter: $value';
    text =
        text.length > totalWidth
            ? text.substring(0, totalWidth)
            : text.padRight(totalWidth);
    return KonsoleAnsi.color(text, fg: fgColor, bgColor: bgColor);
  }

  @override
  void handleInput(String input) {
    if (focused) {
      if (input == '\x1B[A') value++;
      if (input == '\x1B[B') value--;
    }
  }
}
