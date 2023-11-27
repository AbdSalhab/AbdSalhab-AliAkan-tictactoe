import 'package:flutter/material.dart';
import 'game_screen.dart';

class PlayerInfo extends StatefulWidget {
  @override
  _PlayerInfoState createState() => _PlayerInfoState();
}

class _PlayerInfoState extends State<PlayerInfo> {
  late TextEditingController playerXController;
  late TextEditingController playerOController;

  @override
  void initState() {
    super.initState();
    playerXController = TextEditingController();
    playerOController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Player Names'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: playerXController,
              decoration: InputDecoration(labelText: 'Player X Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: playerOController,
              decoration: InputDecoration(labelText: 'Player O Name'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (playerXController.text.isNotEmpty && playerOController.text.isNotEmpty) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => TicTacToe(
                        playerXName: playerXController.text,
                        playerOName: playerOController.text,
                      ),
                    ),
                  );
                } else {
                  // Show an error message if names are not entered
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Please enter names for both players.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('Start Game'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    playerXController.dispose();
    playerOController.dispose();
    super.dispose();
  }
}
