import 'package:konsole/konsole.dart';

import 'counter.dart';

void main() {
  final app = Konsole();

  final counter = Counter(fgColor: KonsoleColors.red, totalWidth: 35);

  final counterBox = Column([
    counter,
    Column([
      Button(
        'Up',
        fgColor: KonsoleColors.magenta,
        onPressed: () => counter.value++,
        customWidth: 10,
      ),
      Button(
        'Down',
        fgColor: KonsoleColors.yellow,
        onPressed: () => counter.value--,
        customWidth: 10,
      ),
    ]),
  ]);

  app.add(
    Row([
      counterBox,
      Column([
        Spinner.line(fgColor: KonsoleColors.cyan),
        Spinner.dot(fgColor: KonsoleColors.yellow),
        Spinner.box(fgColor: KonsoleColors.magenta),
        Spinner(fgColor: KonsoleColors.blue),
      ]),
    ]),
  );

  app.run();
}
