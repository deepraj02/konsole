import 'package:konsole/konsole.dart';

void main() {
  final examples = [
    Text('Default Text'),
    Text.success('Success Text'),
    Text.error('Error Text'),
    Text.warning('Warning Text'),
    Text.info('Info Text'),
    Text.muted('Muted Text'),
    Text.highlight('Highlight Text'),
    Text.title('Title Text'),
    Text.subtitle('Subtitle Text'),
    Text.accent('Accent Text'),
    Text('Bold Text').bold(),
    Text('Italic Text').italic(),
    Text('Underline Text').underline(),
    Text('Custom Color').withColor(KonsoleColors.magenta),
    Text('Custom BG').withBackgroundColor(KonsoleColors.bgCyan),
    Text('Right Aligned', alignment: TextAlignment.right, maxWidth: 30),
    Text('Center Aligned', alignment: TextAlignment.center, maxWidth: 30),
    Text(
      'Wrapped text example that is long enough to demonstrate word wrapping.',
      maxWidth: 20,
      wordWrap: true,
    ),
    Text('With Prefix', prefix: '>> '),
    Text('With Suffix', suffix: ' <<'),
  ];

  final app = Konsole();
  app.add(Column(examples));
  app.run();
}
