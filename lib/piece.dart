import 'package:flutter/material.dart';
import 'board.dart';
import 'values.dart';

class Piece {
  Tetromino type; // type of tetris piece

  Piece({required this.type});

  List<int> position = []; //  piece is just a list of integers

  //color of tetris piece
  Color get color {
    //default to white when no color is found
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L: // generate the integers
        position = [-26, -16, -6, -5];
        break;

      case Tetromino.J: // generate the integers
        position = [-25, -15, -5, -6];
        break;

      case Tetromino.I: // generate the integers
        position = [-4, -5, -6, -7];
        break;

      case Tetromino.O: // generate the integers
        position = [-15, -16, -5, -6];
        break;

      case Tetromino.S: // generate the integers
        position = [-15, -14, -6, -5];
        break;

      case Tetromino.Z: // generate the integers
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T: // generate the integers
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  //moving piece
  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //rotate piece
  int rotationState = 1;
  void rotatePiece() {
    //new position
    List<int> newPosition = [];

    //rotate the piece on its type
    // switch (type) {
    //   case Tetromino.L:
        switch (rotationState) {
          case 0:
            /*
          0
          0
          0 0 
          */
            //get the new position
            newPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //update the new position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
            break;

          case 1:
            /* 
            0 0 0 
            0
            */
            //get the new position
            newPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //update the new position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
            break;

          case 2:
            /*
            0 0
              0
              0
             */
            //get the new position
            newPosition = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            //update the new position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
            break;

          case 3:
            /*
                0
            0 0 0
             */
            //get the new position
            newPosition = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //update the new position
            position = newPosition;
            //update rotation state
            rotationState = (rotationState + 1) % 4;
            break;
          default:
        }
    // }
  }

  //check if valid position
  bool positionIsVal(int val) {
    //get row and coloumn position
    int row = (position.first / rowLength).floor();
    int col = (position.first % rowLength);

    //if the position is occupied return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    else {
      return true;
        }
  }

  //check if piece is valid position
}
