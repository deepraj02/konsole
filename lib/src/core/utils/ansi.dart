import 'package:konsole/konsole.dart';

class Ansi {
  static const clear = '\x1B[2J\x1B[H';
  static const reset = '\x1B[0m';

  static String color(
    String text, {
    String fg = AnsiColors.white,
    String? bgColor,
  }) {
    String code = '';
    if (bgColor != null) code += bgColor;
    code += fg;
    return '$code$text$reset';
  }

  static const cursorHide = '\x1B[?25l';
  static const cursorShow = '\x1B[?25h';
}
