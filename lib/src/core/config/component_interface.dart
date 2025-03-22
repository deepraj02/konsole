abstract class KonsoleComponent {
  int x = 0;
  int y = 0;
  int width;
  int height;
  bool focusable = false;
  bool focused = false;

  KonsoleComponent({this.x = 0, this.y = 0, this.width = 10, this.height = 1});

  String render();
  void update(double dt) {}
  void handleInput(String input) {}
  List<KonsoleComponent> getFocusableComponents() {
    if (focusable) {
      return [this];
    } else {
      return [];
    }
  }
}
