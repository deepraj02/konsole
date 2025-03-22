import 'package:konsole/konsole.dart';

import 'counter.dart';

void main() {
  final app = Konsole();

  final counter = Counter(fgColor: AnsiColors.red, totalWidth: 35);

  final counterBox = Column([
    counter,
    Column([
      Button(
        'Up',
        fgColor: AnsiColors.magenta,
        onPressed: () => counter.value++,
        customWidth: 10,
      ),
      Button(
        'Down',
        fgColor: AnsiColors.yellow,
        onPressed: () => counter.value--,
        customWidth: 10,
      ),
    ]),
  ]);

  app.add(
    Row([
      counterBox,
      Column([
        Spinner.line(fgColor: AnsiColors.cyan),
        Spinner.dot(fgColor: AnsiColors.yellow),
        Spinner.box(fgColor: AnsiColors.magenta),
        Spinner(fgColor: AnsiColors.blue),
      ]),
    ]),
  );

  app.run();
}
