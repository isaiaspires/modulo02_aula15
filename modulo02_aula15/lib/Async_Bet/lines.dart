import 'dart:html';

class Lines {
  int _purple = 0;
  int _blue = 0;
  int _red = 0;

  int get purple => _purple;
  int get blue => _blue;
  int get red => _red;

  bool get notWinner => blue < 100 && purple < 100 && red < 100;

  String? get winner {
    if (red >= 100) return 'Vemelho';
    if (blue >= 100) return 'Azul';
    if (purple >= 100) return 'Roxo';
  }

  void clear() {
    _purple = 0;
    _blue = 0;
    _red = 0;
  }

  void incrementPurple(int value) {
    _purple += value;
  }

  void incrementBlue(int value) {
    _blue += value;
  }

  void incrementRed(int value) {
    _red += value;
  }

  @override
  String toString() => 'Lines(purple: $_purple, blue: $_blue, red: $_red)';
}
