import 'dart:ui';

int rowLength = 10;
int colLength = 15;

enum Tetromino { L, J, I, O, S, Z, T }

enum Direction { left, right, down }

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color.fromARGB(255, 255, 115, 0),
  Tetromino.J: Color.fromARGB(255, 134, 174, 235),
  Tetromino.I: Color.fromARGB(255, 175, 39, 183),
  Tetromino.O: Color(0xFFFFFF00),
  Tetromino.S: Color.fromARGB(255, 20, 227, 30),
  Tetromino.Z: Color.fromARGB(255, 255, 0, 0),
  Tetromino.T: Color.fromARGB(255, 24, 43, 220),
};
