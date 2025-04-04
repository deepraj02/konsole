abstract class KonsoleComponent {
  int marginHorizontal = 0;
  int marginVertical = 0;
  int width;
  int height;
  bool focusable = false;
  bool focused = false;

  KonsoleComponent({
    this.marginHorizontal = 0,
    this.marginVertical = 0,
    this.width = 10,
    this.height = 1,
  });

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
