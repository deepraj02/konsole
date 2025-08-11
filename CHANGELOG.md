## 0.1.0

### Initial Release

- **Konsole TUI Framework for Dart**  
  Introduced a lightweight, component-based terminal UI (TUI) library for Dart, enabling the creation of interactive command-line applications with modern UI features.

### Core Features

- **Component System**
  - `KonsoleComponent`: Abstract base class for all UI components, supporting rendering, input handling, focus management, and updates.
  - Extensible architecture for building custom components.

- **Rich Built-in Components**
  - **Text**: Flexible text component with extensive styling (color, bold, italic, underline, alignment, word wrap, prefix/suffix, and more). Includes factory constructors for common styles (success, error, warning, info, muted, highlight, title, subtitle, accent).
  - **Button**: Interactive button supporting focus, custom width, color, and callback on press.
  - **Box**: Container with multiple border styles, title, hint text, color customization, padding, and content alignment.
  - **Spinner**: Animated loading indicators with multiple styles (default, dot, line, box), customizable color and speed.
  - **Layout Components**: 
    - `Row` and `Column` for horizontal and vertical arrangement of components, with margin support.

- **Application Management**
  - `Konsole` class to manage the application lifecycle, rendering loop, input handling, and focus navigation.
  - Support for tab-based focus switching and keyboard input processing.
  - Graceful application exit and terminal state restoration.

- **ANSI Color Utilities**
  - `KonsoleColors`: Predefined ANSI color constants for foreground and background.
  - `KonsoleAnsi`: Utility for applying color and terminal control sequences (clear, cursor show/hide, reset).

- **Examples and Usage**
  - Example applications demonstrating component usage, layout, and interactivity (see `example/` directory).
  - Comprehensive README with usage instructions, code samples, and component documentation.