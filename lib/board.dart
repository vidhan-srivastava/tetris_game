import 'dart:async';
import 'package:flutter/material.dart';
import 'pixel.dart';
import 'piece.dart';
import 'values.dart';
import 'dart:math';

/*
Game Board
 
This is a 2x2 gridwith null representing an empty space.
A non empty space will have the color to represent the landed pieces 
*/

// create gameBoard
List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L); //current tetris peice

  @override
  void initState() {
    super.initState();
    //start game when app starts
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  //game loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        //check landing
        checkLanding();
        // moving current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  //creating a base ground where the pieces will stop
  //check for collision in a future
  //for collision -> return true else return false

  bool checkCollision(Direction direction) {
    //loop through each position of the current position
    for (int i = 0; i < currentPiece.position.length; i++) {
      //calculate the row and coloumn of the current position
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = (currentPiece.position[i] % rowLength);

      //adjust row and col acc to the posiotion
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      //check if piece is too low or too far to the left or right
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
    }
    //no collisions detected then
    return false;
  }

  //check if landing
  void checkLanding() {
    //if going down is occupied
    if (checkCollision(Direction.down)) {
      //mark position occupied
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = (currentPiece.position[i] % rowLength);
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      createNewPiece();
    }
  }

  void createNewPiece() {
    //create a random object to generate randomtetromino types
    Random rand = Random();

    //create a new piece of random type
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();
  }

  //left
  void moveLeft() {
    //make sure the move is valid before moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  //rotate piece
  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  //right
  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          //Game Grid
          Expanded(
            child: GridView.builder(
              itemCount: rowLength * colLength,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rowLength,
              ),
              itemBuilder: (context, index) {
                int row = (index / rowLength).floor();
                int col = (index % rowLength);

                if (currentPiece.position.contains(index)) {
                  return Pixel(
                    //current piece
                    color: currentPiece.color,
                    digit: index,
                  );
                }
                //landed pieces
                else if (gameBoard[row][col] != null) {
                  final Tetromino? tetrominoType = gameBoard[row][col];
                  return Pixel(
                      color: tetrominoColors[tetrominoType], digit: '');
                } else {
                  return Pixel(
                    //blank pixel
                    color: Colors.black,
                    digit: index,
                  );
                }
              },
            ),
          ),

          // Game Controls
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                //rotate
                IconButton(
                  onPressed: rotatePiece,
                  color: Colors.white,
                  icon: const Icon(Icons.rotate_right),
                ),
                //rirght
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
