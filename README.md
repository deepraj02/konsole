# Konsole - A lightweight TUI framework for Dart 🎯

A modern, feature-rich terminal UI framework for Dart. Build interactive command-line interfaces with ease using a component-based architecture.

Konsole provides a simple yet powerful way to create terminal applications with rich UI components like boxes, buttons, spinners, and more.


## Features

- 🎨 **Rich component library** - Buttons, boxes, spinners, text labels, and more
- 📊 **Flexible layout system** - Use rows and columns for intuitive layouts
- 🎯 **Focus management** - Tab navigation between interactive elements
- 🌈 **ANSI color support** - Full terminal color customization
- ⌨️ **Input handling** - Process keyboard input from your users
- 🔄 **Update loop** - Automatic rendering with animation support

## Installation

Add Konsole to your `pubspec.yaml`:

```yaml
dependencies:
  konsole: ^1.0.0
```

Then run:

```bash
dart pub get
```

## Core Concepts

Konsole is built around a few simple concepts:

- **Components**: UI elements like Button, Text, Box
- **Layouts**: Row and Column components for organizing elements
- **Application**: The main Konsole class that manages components and rendering
- **Input Handling**: Each component can respond to user input

## Components

### Basic Components

| Component | Description                                     |
| --------- | ----------------------------------------------- |
| `Text`    | Simple text display with color support          |
| `Button`  | Interactive button with callback support        |
| `Box`     | Container with border and optional title        |
| `Spinner` | Animated loading indicator with multiple styles |

More to come.

### Layout Components

| Component | Description                 |
| --------- | --------------------------- |
| `Row`     | Horizontal layout container |
| `Column`  | Vertical layout container   |

## Usage

### Simple Example

```dart
import 'package:konsole/konsole.dart';

void main() {
  final app = Konsole();
  
  app.add(Text("Hello Konsole!", fgColor: AnsiColors.green));
  
  app.run();
}
```

### Interactive Counter Example

```dart
import 'package:konsole/konsole.dart';

void main() {
  final app = Konsole();

  final counter = Counter(fgColor: AnsiColors.red);
  
  app.add(Box(
    Column([
      counter,
      Row([
        Button("Increment", onPressed: () => counter.value++),
        Button("Decrement", onPressed: () => counter.value--),
      ]),
    ]),
    title: "Counter Demo",
  ));
  
  app.run();
}
```

### Complex Layout Example

```dart
import 'package:konsole/konsole.dart';

class Counter extends KonsoleComponent {
  int value;
  String fgColor;
  String? bgColor;
  int totalWidth;

  Counter({
    this.value = 0,
    this.fgColor = AnsiColors.white,
    this.bgColor,
    this.totalWidth = 20,
    super.x,
    super.y,
  }) : super(width: totalWidth, height: 1) {
    focusable = true;
  }

  @override
  String render() {
    String text = 'Counter: $value';
    text =
        text.length > totalWidth
            ? text.substring(0, totalWidth)
            : text.padRight(totalWidth);
    return Ansi.color(text, fg: fgColor, bgColor: bgColor);
  }

  @override
  void handleInput(String input) {
    if (focused) {
      if (input == '\x1B[A') value++;
      if (input == '\x1B[B') value--;
    }
  }
}



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
```

## Component Details

### Text

Display styled text with color support:

```dart
Text(
  "Hello World",
  fgColor: AnsiColors.green,
  bgColor: AnsiColors.bgBlack,
)
```

### Button

Interactive button that can respond to user input:

```dart
Button(
  "Click Me",
  fgColor: AnsiColors.white,
  bgColor: AnsiColors.bgBlue,
  onPressed: () => print("Button clicked!"),
)
```

### Box

Container with border and optional title:

```dart
Box(
  Text("Content inside box"),
  title: "Box Title",
  fgColor: AnsiColors.cyan,
)
```

### Spinner

Animated loading indicators with multiple styles:

```dart
// Default spinner '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏'
Spinner(fgColor: AnsiColors.blue)

// Dot-style spinner '.', '..', '...', '....'
Spinner.dot(fgColor: AnsiColors.yellow)

// Line-style spinner
Spinner.line(fgColor: AnsiColors.cyan)

// Box-style spinner  '□', '■', '▣', '▢'
Spinner.box(fgColor: AnsiColors.magenta)
```

### Counter

Interactive numeric counter:

```dart
Counter(
  value: 10,
  fgColor: AnsiColors.red,
  totalWidth: 20, 
)
```

## Key Navigation

- `Tab`: Move focus between interactive components
- `Enter`: Activate focused buttons
- `Up/Down Arrow`: Interact with counter components
- `q`: Quit the application

## Color Support

Konsole provides built-in ANSI color constants:

```dart
// Foreground colors
AnsiColors.black
AnsiColors.red
AnsiColors.green
AnsiColors.yellow
AnsiColors.blue
AnsiColors.magenta
AnsiColors.cyan
AnsiColors.white

// Background colors
AnsiColors.bgBlack
AnsiColors.bgRed
AnsiColors.bgGreen
AnsiColors.bgYellow
AnsiColors.bgBlue
AnsiColors.bgMagenta
AnsiColors.bgCyan
AnsiColors.bgWhite
```

## Creating Custom Components

Extend the `KonsoleComponent` class to create your own components:

```dart
class MyCustomComponent extends KonsoleComponent {
  MyCustomComponent({super.x, super.y}) : super(width: 10, height: 1);

  @override
  String render() {
    return "My custom component";
  }
  
  @override
  void handleInput(String input) {
    // Handle input here
  }
  
  @override
  void update(double dt) {
    // Update state here
  }
}
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request
