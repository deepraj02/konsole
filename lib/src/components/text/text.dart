import 'package:konsole/konsole.dart';

class Text extends KonsoleComponent {
  String content;
  String fgColor;
  String? bgColor; // Optional background, defaults to transparent

  Text(
    this.content, {
    this.fgColor = AnsiColors.white,
    this.bgColor,
    super.x,
    super.y,
  }) : super(width: content.length);

  @override
  String render() => Ansi.color(content, fg: fgColor, bgColor: bgColor);
}
