import 'package:konsole/konsole.dart';

/// Text styling options for enhanced text rendering
class TextStyle {
  final String foregroundColor;
  final String? backgroundColor;
  final bool bold;
  final bool italic;
  final bool underline;
  final bool strikethrough;
  final bool dim;
  final bool blink;
  final bool reverse;

  const TextStyle({
    this.foregroundColor = KonsoleColors.white,
    this.backgroundColor,
    this.bold = false,
    this.italic = false,
    this.underline = false,
    this.strikethrough = false,
    this.dim = false,
    this.blink = false,
    this.reverse = false,
  });

  /// Predefined text styles for common use cases
  static const TextStyle success = TextStyle(
    foregroundColor: KonsoleColors.green,
    bold: true,
  );
  static const TextStyle error = TextStyle(
    foregroundColor: KonsoleColors.red,
    bold: true,
  );
  static const TextStyle warning = TextStyle(
    foregroundColor: KonsoleColors.yellow,
    bold: true,
  );
  static const TextStyle info = TextStyle(foregroundColor: KonsoleColors.cyan);
  static const TextStyle muted = TextStyle(
    foregroundColor: KonsoleColors.white,
    dim: true,
  );
  static const TextStyle highlight = TextStyle(
    foregroundColor: KonsoleColors.black,
    backgroundColor: KonsoleColors.bgYellow,
  );
  static const TextStyle title = TextStyle(
    foregroundColor: KonsoleColors.cyan,
    bold: true,
    underline: true,
  );
  static const TextStyle subtitle = TextStyle(
    foregroundColor: KonsoleColors.magenta,
    bold: true,
  );
  static const TextStyle accent = TextStyle(
    foregroundColor: KonsoleColors.yellow,
    italic: true,
  );
}

/// Text alignment options
enum TextAlignment { left, center, right }

/// Enhanced Text component with comprehensive styling and formatting options

class Text extends KonsoleComponent {
  String content;
  TextStyle style;
  TextAlignment alignment;
  int? maxWidth;
  bool wordWrap;
  String? prefix;
  String? suffix;

  Text(
    this.content, {
    this.style = const TextStyle(),
    this.alignment = TextAlignment.left,
    this.maxWidth,
    this.wordWrap = false,
    this.prefix,
    this.suffix,
    super.marginHorizontal,
    super.marginVertical,
  }) : super(width: _calculateWidth(content, maxWidth, prefix, suffix));

  // Factory constructors for common styles
  factory Text.success(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.success,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.error(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.error,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.warning(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.warning,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.info(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.info,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.muted(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.muted,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.highlight(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.highlight,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.title(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.title,
    alignment: TextAlignment.center,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.subtitle(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.subtitle,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  factory Text.accent(
    String content, {
    int? marginHorizontal,
    int? marginVertical,
  }) => Text(
    content,
    style: TextStyle.accent,
    alignment: TextAlignment.left,
    marginHorizontal: marginHorizontal ?? 0,
    marginVertical: marginVertical ?? 0,
  );

  static int _calculateWidth(
    String content,
    int? maxWidth,
    String? prefix,
    String? suffix,
  ) {
    var totalLength = content.length;
    if (prefix != null) totalLength += prefix.length;
    if (suffix != null) totalLength += suffix.length;

    if (maxWidth != null && totalLength > maxWidth) {
      return maxWidth;
    }
    return totalLength;
  }

  @override
  String render() {
    // Apply prefix and suffix
    var displayContent = content;
    if (prefix != null) displayContent = prefix! + displayContent;
    if (suffix != null) displayContent = displayContent + suffix!;

    // Handle word wrapping if enabled and maxWidth is set
    if (wordWrap && maxWidth != null && displayContent.length > maxWidth!) {
      displayContent = _wrapText(displayContent, maxWidth!);
    }

    // Apply text alignment
    if (maxWidth != null && displayContent.length < maxWidth!) {
      displayContent = _applyAlignment(displayContent, maxWidth!);
    }

    // Apply styling
    return _applyTextStyle(displayContent, style);
  }

  String _wrapText(String text, int width) {
    if (text.length <= width) return text;

    final words = text.split(' ');
    final lines = <String>[];
    var currentLine = '';

    for (final word in words) {
      if (currentLine.isEmpty) {
        currentLine = word;
      } else if (('$currentLine $word').length <= width) {
        currentLine += ' $word';
      } else {
        lines.add(currentLine);
        currentLine = word;
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine);
    }

    return lines.join('\n');
  }

  String _applyAlignment(String text, int width) {
    final lines = text.split('\n');
    final alignedLines = <String>[];

    for (final line in lines) {
      switch (alignment) {
        case TextAlignment.left:
          alignedLines.add(line.padRight(width));
          break;
        case TextAlignment.center:
          final padding = (width - line.length) ~/ 2;
          final paddedLine =
              ' ' * padding + line + ' ' * (width - line.length - padding);
          alignedLines.add(paddedLine);
          break;
        case TextAlignment.right:
          alignedLines.add(line.padLeft(width));
          break;
      }
    }

    return alignedLines.join('\n');
  }

  String _applyTextStyle(String text, TextStyle style) {
    var styledText = text;

    // Build ANSI escape sequence for styling
    final ansiCodes = <String>[];

    // Text formatting
    if (style.bold) ansiCodes.add('1');
    if (style.dim) ansiCodes.add('2');
    if (style.italic) ansiCodes.add('3');
    if (style.underline) ansiCodes.add('4');
    if (style.blink) ansiCodes.add('5');
    if (style.reverse) ansiCodes.add('7');
    if (style.strikethrough) ansiCodes.add('9');

    // Colors
    ansiCodes.add(_getColorCode(style.foregroundColor, false));
    if (style.backgroundColor != null) {
      ansiCodes.add(_getColorCode(style.backgroundColor!, true));
    }

    if (ansiCodes.isNotEmpty) {
      styledText = '\x1B[${ansiCodes.join(';')}m$text\x1B[0m';
    }

    return styledText;
  }

  String _getColorCode(String color, bool isBackground) {
    final colorMap = {
      KonsoleColors.black: isBackground ? '40' : '30',
      KonsoleColors.red: isBackground ? '41' : '31',
      KonsoleColors.green: isBackground ? '42' : '32',
      KonsoleColors.yellow: isBackground ? '43' : '33',
      KonsoleColors.blue: isBackground ? '44' : '34',
      KonsoleColors.magenta: isBackground ? '45' : '35',
      KonsoleColors.cyan: isBackground ? '46' : '36',
      KonsoleColors.white: isBackground ? '47' : '37',
    };

    return colorMap[color] ?? (isBackground ? '47' : '37');
  }

  /// Update text content
  void updateContent(String newContent) {
    content = newContent;
    width = _calculateWidth(content, maxWidth, prefix, suffix);
  }

  /// Update text style
  void updateStyle(TextStyle newStyle) {
    style = newStyle;
  }
}

// Extension methods for fluent API
extension TextStyleExtensions on Text {
  Text withColor(String color) => Text(
    content,
    style: TextStyle(
      foregroundColor: color,
      backgroundColor: style.backgroundColor,
      bold: style.bold,
      italic: style.italic,
      underline: style.underline,
      strikethrough: style.strikethrough,
      dim: style.dim,
      blink: style.blink,
      reverse: style.reverse,
    ),
    alignment: alignment,
    maxWidth: maxWidth,
    wordWrap: wordWrap,
    prefix: prefix,
    suffix: suffix,
    marginHorizontal: marginHorizontal,
    marginVertical: marginVertical,
  );

  Text withBackgroundColor(String color) => Text(
    content,
    style: TextStyle(
      foregroundColor: style.foregroundColor,
      backgroundColor: color,
      bold: style.bold,
      italic: style.italic,
      underline: style.underline,
      strikethrough: style.strikethrough,
      dim: style.dim,
      blink: style.blink,
      reverse: style.reverse,
    ),
    alignment: alignment,
    maxWidth: maxWidth,
    wordWrap: wordWrap,
    prefix: prefix,
    suffix: suffix,
    marginHorizontal: marginHorizontal,
    marginVertical: marginVertical,
  );

  Text bold() => Text(
    content,
    style: TextStyle(
      foregroundColor: style.foregroundColor,
      backgroundColor: style.backgroundColor,
      bold: true,
      italic: style.italic,
      underline: style.underline,
      strikethrough: style.strikethrough,
      dim: style.dim,
      blink: style.blink,
      reverse: style.reverse,
    ),
    alignment: alignment,
    maxWidth: maxWidth,
    wordWrap: wordWrap,
    prefix: prefix,
    suffix: suffix,
    marginHorizontal: marginHorizontal,
    marginVertical: marginVertical,
  );

  Text italic() => Text(
    content,
    style: TextStyle(
      foregroundColor: style.foregroundColor,
      backgroundColor: style.backgroundColor,
      bold: style.bold,
      italic: true,
      underline: style.underline,
      strikethrough: style.strikethrough,
      dim: style.dim,
      blink: style.blink,
      reverse: style.reverse,
    ),
    alignment: alignment,
    maxWidth: maxWidth,
    wordWrap: wordWrap,
    prefix: prefix,
    suffix: suffix,
    marginHorizontal: marginHorizontal,
    marginVertical: marginVertical,
  );

  Text underline() => Text(
    content,
    style: TextStyle(
      foregroundColor: style.foregroundColor,
      backgroundColor: style.backgroundColor,
      bold: style.bold,
      italic: style.italic,
      underline: true,
      strikethrough: style.strikethrough,
      dim: style.dim,
      blink: style.blink,
      reverse: style.reverse,
    ),
    alignment: alignment,
    maxWidth: maxWidth,
    wordWrap: wordWrap,
    prefix: prefix,
    suffix: suffix,
    marginHorizontal: marginHorizontal,
    marginVertical: marginVertical,
  );
}
