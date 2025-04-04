import 'package:konsole/konsole.dart';

enum BoxType {
  single,
  double,
  round,
  bold,
  singleDouble,
  doubleSingle,
  classic,
  corner,
}

enum ContentAlignment { left, center, right }

enum TitlePosition { top, inside, bottom }

class BoxColor {
  final String? name;
  final int? hex;
  final List<int>? rgb;

  const BoxColor.named(this.name) : hex = null, rgb = null;
  const BoxColor.hex(this.hex) : name = null, rgb = null;
  const BoxColor.rgb(this.rgb) : name = null, hex = null;

  String apply(String text) {
    if (name != null) {
      return KonsoleAnsi.color(text, fg: name!);
    } else if (hex != null || rgb != null) {
      return KonsoleAnsi.color(text);
    }
    return text;
  }
}

class Box extends KonsoleComponent {
  final KonsoleComponent child;
  final String? title;
  final BoxColor? boxColor;
  final BoxColor? titleColor;
  final BoxColor? contentColor;
  final int paddingHorizontal;
  final int paddingVertical;
  final ContentAlignment contentAlign;
  final ContentAlignment titleAlign;
  final TitlePosition titlePosition;
  final String topLeft;
  final String topRight;
  final String bottomLeft;
  final String bottomRight;
  final String horizontal;
  final String vertical;
  final String? hintText;

  Box({
    required this.child,
    this.title,
    this.boxColor,
    this.titleColor,
    this.contentColor,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    this.contentAlign = ContentAlignment.left,
    this.titleAlign = ContentAlignment.left,
    this.titlePosition = TitlePosition.top,
    this.topLeft = '┌',
    this.topRight = '┐',
    this.bottomLeft = '└',
    this.bottomRight = '┘',
    this.horizontal = '─',
    this.vertical = '│',
    this.hintText,
    super.marginHorizontal,
    super.marginVertical,
  }) : super(
         width: _calculateWidth(child, title, paddingHorizontal, hintText),
         height: _calculateHeight(
           child,
           title,
           paddingVertical,
           titlePosition == TitlePosition.inside,
         ),
       ) {
    int titleOffset =
        (title != null && titlePosition == TitlePosition.top) ? 2 : 0;
    child.marginHorizontal = marginHorizontal + 1 + paddingHorizontal;
    child.marginVertical = marginVertical + 1 + paddingVertical + titleOffset;
  }

  factory Box.styled({
    required BoxType style,
    required KonsoleComponent child,
    String? title,
    BoxColor? boxColor,
    BoxColor? titleColor,
    BoxColor? contentColor,
    int px = 0,
    int py = 0,
    ContentAlignment contentAlign = ContentAlignment.left,
    ContentAlignment titleAlign = ContentAlignment.left,
    TitlePosition titlePosition = TitlePosition.top,
    String? hintText,
    int marginHorizontal = 0,
    int marginVertical = 0,
  }) {
    final styleConfig = _boxStyles[style]!;
    return Box(
      child: child,
      title: title,
      boxColor: boxColor,
      titleColor: titleColor,
      contentColor: contentColor,
      paddingHorizontal: px,
      paddingVertical: py,
      contentAlign: contentAlign,
      titleAlign: titleAlign,
      titlePosition: titlePosition,
      topLeft: styleConfig['topLeft']!,
      topRight: styleConfig['topRight']!,
      bottomLeft: styleConfig['bottomLeft']!,
      bottomRight: styleConfig['bottomRight']!,
      horizontal: styleConfig['horizontal']!,
      vertical: styleConfig['vertical']!,
      hintText: hintText,
      marginHorizontal: marginHorizontal,
      marginVertical: marginVertical,
    );
  }

  static final Map<BoxType, Map<String, String>> _boxStyles = {
    BoxType.single: {
      'topLeft': '┌',
      'topRight': '┐',
      'bottomLeft': '└',
      'bottomRight': '┘',
      'horizontal': '─',
      'vertical': '│',
    },
    BoxType.double: {
      'topLeft': '╔',
      'topRight': '╗',
      'bottomLeft': '╚',
      'bottomRight': '╝',
      'horizontal': '═',
      'vertical': '║',
    },
    BoxType.round: {
      'topLeft': '╭',
      'topRight': '╮',
      'bottomLeft': '╰',
      'bottomRight': '╯',
      'horizontal': '─',
      'vertical': '│',
    },
    BoxType.bold: {
      'topLeft': '┏',
      'topRight': '┓',
      'bottomLeft': '┗',
      'bottomRight': '┛',
      'horizontal': '━',
      'vertical': '┃',
    },
    BoxType.singleDouble: {
      'topLeft': '╓',
      'topRight': '╖',
      'bottomLeft': '╙',
      'bottomRight': '╜',
      'horizontal': '─',
      'vertical': '║',
    },
    BoxType.doubleSingle: {
      'topLeft': '╒',
      'topRight': '╕',
      'bottomLeft': '╘',
      'bottomRight': '╛',
      'horizontal': '═',
      'vertical': '│',
    },
    BoxType.classic: {
      'topLeft': '+',
      'topRight': '+',
      'bottomLeft': '+',
      'bottomRight': '+',
      'horizontal': '-',
      'vertical': '|',
    },
    BoxType.corner: {
      'topLeft': '+',
      'topRight': '+',
      'bottomLeft': '+',
      'bottomRight': '+',
      'horizontal': ' ',
      'vertical': ' ',
    },
  };

  static int _calculateWidth(
    KonsoleComponent child,
    String? title,
    int px,
    String? ins,
  ) {
    final childLines = child.render().split('\n');
    int maxChildWidth = childLines
        .map((line) => _stripAnsi(line).length)
        .fold(0, (a, b) => a > b ? a : b);
    int maxWidth = maxChildWidth;
    if (title != null && _stripAnsi(title).length > maxWidth) {
      maxWidth = _stripAnsi(title).length;
    }
    if (ins != null && _stripAnsi(ins).length > maxWidth) {
      maxWidth = _stripAnsi(ins).length;
    }
    return maxWidth + 2 + (px * 2);
  }

  static int _calculateHeight(
    KonsoleComponent child,
    String? title,
    int py,
    bool titleInside,
  ) {
    int height = child.height;

    if (title != null && !titleInside) {
      height += 1;
    }
    return height + 2 + (py * 2);
  }

  String _createBorderWithTitle(String title, int contentWidth, bool isTop) {
    final coloredTitle = titleColor?.apply(title) ?? title;
    final leftBorder = isTop ? topLeft : bottomLeft;
    final rightBorder = isTop ? topRight : bottomRight;

    final leftBorderStr =
        boxColor?.apply('$leftBorder$horizontal ') ?? '$leftBorder$horizontal ';
    final rightSideLength =
        contentWidth + (paddingHorizontal * 2) - _stripAnsi(title).length - 3;
    final rightBorderStr =
        boxColor?.apply('${horizontal * rightSideLength}$rightBorder') ??
        '${horizontal * rightSideLength}$rightBorder';

    return '$leftBorderStr$coloredTitle$rightBorderStr';
  }

  @override
  String render() {
    final lines = <String>[];
    final contentWidth = width - 2 - (paddingHorizontal * 2);
    final childLines = child.render().split('\n');

    String topBar =
        '$topLeft${horizontal * (contentWidth + (paddingHorizontal * 2))}$topRight';
    String bottomBar =
        '$bottomLeft${horizontal * (contentWidth + (paddingHorizontal * 2))}$bottomRight';

    if (title != null) {
      switch (titlePosition) {
        case TitlePosition.top:
          topBar = _createBorderWithTitle(title!, contentWidth, true);
          break;
        case TitlePosition.bottom:
          bottomBar = _createBorderWithTitle(title!, contentWidth, false);
          break;
        case TitlePosition.inside:
          break;
      }
    }

    if (hintText != null &&
        (title == null || titlePosition != TitlePosition.bottom)) {
      final coloredIns = titleColor?.apply(hintText!) ?? hintText!;
      final leftBorder =
          boxColor?.apply('$bottomLeft$horizontal ') ??
          '$bottomLeft$horizontal ';
      final rightSideLength =
          contentWidth +
          (paddingHorizontal * 2) -
          _stripAnsi(hintText!).length -
          3;
      final rightBorder =
          boxColor?.apply('${horizontal * rightSideLength}$bottomRight') ??
          '${horizontal * rightSideLength}$bottomRight';

      bottomBar = '$leftBorder$coloredIns$rightBorder';
    }

    if (boxColor != null) {
      if (title == null || titlePosition != TitlePosition.top) {
        topBar = boxColor!.apply(topBar);
      }
      if ((title == null || titlePosition != TitlePosition.bottom) &&
          hintText == null) {
        bottomBar = boxColor!.apply(bottomBar);
      }
    }

    lines.add(topBar);

    for (int i = 0; i < paddingVertical; i++) {
      lines.add(_buildPaddedLine(contentWidth));
    }

    if (title != null && titlePosition == TitlePosition.inside) {
      final coloredTitle = titleColor?.apply(title!) ?? title!;
      lines.add(_alignContent(coloredTitle, contentWidth, titleAlign));
      lines.add(_buildPaddedLine(contentWidth));
    }

    for (var line in childLines) {
      final coloredLine = contentColor?.apply(line) ?? line;
      lines.add(_alignContent(coloredLine, contentWidth, contentAlign));
    }

    for (int i = 0; i < paddingVertical; i++) {
      lines.add(_buildPaddedLine(contentWidth));
    }

    lines.add(bottomBar);

    return lines.join('\n');
  }

  String _buildPaddedLine(int width) {
    final padding = ' ' * (width + paddingHorizontal);
    final coloredVertical = boxColor?.apply(vertical) ?? vertical;
    return '$coloredVertical${' ' * paddingHorizontal}$padding$coloredVertical';
  }

  String _alignContent(
    String content,
    int maxWidth,
    ContentAlignment alignment,
  ) {
    String visibleContent = _stripAnsi(content);
    final diff = maxWidth - visibleContent.length;
    String leftPadding = '';
    String rightPadding = '';
    final coloredVertical = boxColor?.apply(vertical) ?? vertical;

    switch (alignment) {
      case ContentAlignment.center:
        leftPadding = ' ' * (diff ~/ 2);
        rightPadding = ' ' * (diff - (diff ~/ 2));
        break;
      case ContentAlignment.right:
        leftPadding = ' ' * (diff >= 0 ? diff : 0);
        break;
      case ContentAlignment.left:
        rightPadding = ' ' * (diff >= 0 ? diff : 0);
        break;
    }

    return '$coloredVertical${' ' * paddingHorizontal}$leftPadding$content$rightPadding$coloredVertical';
  }

  @override
  void update(double dt) => child.update(dt);

  @override
  void handleInput(String input) => child.handleInput(input);

  @override
  List<KonsoleComponent> getFocusableComponents() =>
      child.getFocusableComponents();

  static String _stripAnsi(String text) {
    return text.replaceAll(RegExp(r'\x1B\[[0-9;]*m'), '');
  }
}
