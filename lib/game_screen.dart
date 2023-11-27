import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  final String playerXName;
  final String playerOName;

  TicTacToe({
    required this.playerXName,
    required this.playerOName,
  });

  @override
  _TicTacToeState createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));

  bool isPlayerX = true; // X starts the game
  int playerXWins = 0;
  int playerOWins = 0;
  int playerXLosses = 0;
  int playerOLosses = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isPlayerX ? '${widget.playerXName}\'s turn' : '${widget.playerOName}\'s turn',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: 9,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;

                return GestureDetector(
                  onTap: () {
                    if (board[row][col].isEmpty) {
                      setState(() {
                        board[row][col] = isPlayerX ? 'X' : 'O';
                        isPlayerX = !isPlayerX;
                      });

                      if (_checkWinner(row, col)) {
                        _showWinnerDialog(isPlayerX ? widget.playerXName : widget.playerOName);
                        _updateScores(isPlayerX);
                      } else if (_isBoardFull()) {
                        _showDrawDialog();
                      }
                    }
                  },
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        board[row][col],
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('${widget.playerXName} Wins: $playerXWins'),
                    Text('${widget.playerXName} Losses: $playerXLosses'),
                  ],
                ),
                Column(
                  children: [
                    Text('${widget.playerOName} Wins: $playerOWins'),
                    Text('${widget.playerOName} Losses: $playerOLosses'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _checkWinner(int row, int col) {
    // Check row, column, and diagonals for a winner
    if (board[row][0] == board[row][1] && board[row][1] == board[row][2] && board[row][0].isNotEmpty) {
      return true;
    }
    if (board[0][col] == board[1][col] && board[1][col] == board[2][col] && board[0][col].isNotEmpty) {
      return true;
    }
    if ((row == col || row + col == 2) &&
        ((board[0][0] == board[1][1] && board[1][1] == board[2][2]) ||
            (board[0][2] == board[1][1] && board[1][1] == board[2][0])) &&
        board[1][1].isNotEmpty) {
      return true;
    }

    return false;
  }

  bool _isBoardFull() {
    // Check if the board is full
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        if (board[i][j].isEmpty) {
          return false;
        }
      }
    }
    return true;
  }

  void _resetBoard() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      isPlayerX = true;
    });
  }

  void _updateScores(bool isPlayerXWinner) {
    setState(() {
      if (isPlayerXWinner) {
        playerXWins++;
        playerOLosses++;
      } else {
        playerOWins++;
        playerXLosses++;
      }
    });
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$winner wins!'),
          actions: [
            TextButton(
              onPressed: () {
                _resetBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  void _showDrawDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('It\'s a draw!'),
          actions: [
            TextButton(
              onPressed: () {
                _resetBoard();
                Navigator.of(context).pop();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
