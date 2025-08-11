import 'package:konsole/konsole.dart';

import 'counter.dart';

void main() {
  final app = Konsole();

  final counter = Counter(fgColor: KonsoleColors.red, totalWidth: 35);

  final counterBox = Box.styled(
    style: BoxType.round,
    child: Column([
      Row([counter]),
    ]),
    boxColor: BoxColor.named(KonsoleColors.cyan),
    title: "Counter",
    titlePosition: TitlePosition.top,
    titleColor: BoxColor.named(KonsoleColors.yellow),
    py: 1,
    contentAlign: ContentAlignment.center,
    hintText: "q(Quit)",
  );

  final componentsShowcase = Box.styled(
    style: BoxType.bold,
    child: Column([
      Text.highlight("Component Showcase", ),
      Row([
        Spinner.line(fgColor: KonsoleColors.cyan),
        Spinner.dot(fgColor: KonsoleColors.yellow),
        Spinner.box(fgColor: KonsoleColors.magenta),
        Spinner(fgColor: KonsoleColors.blue),
      ], marginVertical: 1),
      Row([
        Button('Click me', fgColor: KonsoleColors.green, customWidth: 20),
        Button('Navigate', fgColor: KonsoleColors.cyan, customWidth: 20),
      ], marginVertical: 1),
      Text(
        "Use Tab to navigate between components",

      ),
    ]),
    boxColor: BoxColor.named(KonsoleColors.cyan),
    title: "Components",
    titlePosition: TitlePosition.top,
    titleColor: BoxColor.named(KonsoleColors.yellow),
    py: 2,
    marginVertical: 10,
  );

  app.add(counterBox);
  app.add(componentsShowcase);

  app.run();
}
