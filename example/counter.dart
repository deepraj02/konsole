import 'package:konsole/konsole.dart';

class Counter extends KonsoleComponent {
  int value;
  String fgColor;
  int totalWidth;

  Counter({
    this.value = 0,
    this.fgColor = KonsoleColors.white,
    this.totalWidth = 20,
    super.marginHorizontal,
    super.marginVertical,
  }) : super(width: totalWidth, height: 1) {
    focusable = true;
  }

  @override
  String render() {
    String text = 'Counter: $value';
    if (focused) {
      int contentWidth = totalWidth - 2;
      text =
          text =
              text.length > contentWidth
                  ? text.substring(0, contentWidth)
                  : text;
      text = "[$text]".padRight(totalWidth);
    } else {
      text =
          text.length > totalWidth
              ? text.substring(0, totalWidth)
              : text.padRight(totalWidth);
    }
    return KonsoleAnsi.color(text, fg: fgColor);
  }

  @override
  void handleInput(String input) {
    if (focused) {
      if (input == '\x1B[A') value++;
      if (input == '\x1B[B') value--;
    }
  }
}
