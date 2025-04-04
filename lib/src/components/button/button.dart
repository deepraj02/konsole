import 'package:konsole/konsole.dart';

class Button extends KonsoleComponent {
  final String label;
  final String fgColor;
  final String? bgColor;
  final Function? onPressed;
  final int customWidth;

  Button(
    this.label, {
    this.fgColor = KonsoleColors.white,
    this.bgColor,
    this.onPressed,
    this.customWidth = 10,
    super.marginHorizontal,
    super.marginVertical,
  }) : super(width: customWidth, height: 1) {
    focusable = true;
  }

  @override
  String render() {
    String text = label;
    if (focused) {
      int contentWidth = customWidth - 2;
      text =
          text.length > contentWidth ? text.substring(0, contentWidth) : text;
      text = "[$text]".padRight(customWidth);
    } else {
      text =
          text.length > customWidth
              ? text.substring(0, customWidth)
              : text.padRight(customWidth);
    }
    return KonsoleAnsi.color(text, fg: fgColor, bgColor: bgColor);
  }

  @override
  void handleInput(String input) {
    if ((input == '\r' || input == '\n') && focused && onPressed != null) {
      onPressed!();
    }
  }
}
