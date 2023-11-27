import 'package:flutter/material.dart';
import 'player_info.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: PlayerInfo(),
    );
  }
}
