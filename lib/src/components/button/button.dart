import 'package:konsole/konsole.dart';

class Button extends KonsoleComponent {
  String label;
  String fgColor;
  int? bgColor;
  Function()? onPressed;
  int? customWidth;

  Button(
    this.label, {
    this.fgColor = AnsiColors.white,
    this.bgColor,
    this.onPressed,
    this.customWidth,
    super.x,
    super.y,
  }) : super(width: customWidth ?? (label.length + 4), height: 1) {
    focusable = true;
  }

  @override
  String render() {
    String text = focused ? '[$label]' : ' $label ';
    if (customWidth != null) {
      text =
          text.length > customWidth!
              ? text.substring(0, customWidth!)
              : text.padRight(customWidth!);
    }
    String? effectiveBg = (focused ? AnsiColors.bgBlue : bgColor) as String?;
    return Ansi.color(text, fg: fgColor, bgColor: effectiveBg);
  }

  @override
  void handleInput(String input) {
    if (input == '\r' && focused && onPressed != null) {
      onPressed!();
    }
  }
}
