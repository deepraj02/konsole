import 'dart:math';

import 'package:konsole/konsole.dart';

class Spinner extends KonsoleComponent {
  String fgColor;
  double _phase = 0;
  List<String> frames;
  double speed;

  Spinner._({
    required this.frames,
    this.fgColor = KonsoleColors.white,
    this.speed = 5.0,
    super.marginHorizontal,
    super.marginVertical,
  }) : super(width: frames.map((f) => f.length).reduce(max));

  factory Spinner({
    String fgColor = KonsoleColors.white,
    int marginHorizontal = 0,
    int marginVertical = 0,
  }) => Spinner._(
    frames: ['⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'],
    fgColor: fgColor,
    marginHorizontal: marginHorizontal,
    marginVertical: marginVertical,
  );

  factory Spinner.dot({
    String fgColor = KonsoleColors.white,
    int x = 0,
    int y = 0,
  }) => Spinner._(
    frames: ['.', '..', '...', '....'],
    fgColor: fgColor,
    speed: 2.0,
    marginHorizontal: x,
    marginVertical: y,
  );

  factory Spinner.line({
    String fgColor = KonsoleColors.white,
    int x = 0,
    int y = 0,
  }) => Spinner._(
    frames: ['-', '\\', '|', '/'],
    fgColor: fgColor,
    marginHorizontal: x,
    marginVertical: y,
  );

  factory Spinner.box({
    String fgColor = KonsoleColors.white,
    int x = 0,
    int y = 0,
  }) => Spinner._(
    frames: ['□', '■', '▣', '▢'],
    fgColor: fgColor,
    speed: 3.0,
    marginHorizontal: x,
    marginVertical: y,
  );

  @override
  void update(double dt) {
    _phase += dt * speed;
    if (_phase >= frames.length) _phase = 0;
  }

  @override
  String render() => KonsoleAnsi.color(frames[_phase.floor()], fg: fgColor);
}
