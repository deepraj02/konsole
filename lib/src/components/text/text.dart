import 'package:konsole/konsole.dart';

class Text extends KonsoleComponent {
  String content;
  String fgColor;
  String? bgColor;

  Text(
    this.content, {
    this.fgColor = KonsoleColors.white,
    this.bgColor,
    super.marginHorizontal,
    super.marginVertical,
  }) : super(width: content.length);

  @override
  String render() => KonsoleAnsi.color(content, fg: fgColor, bgColor: bgColor);
}
