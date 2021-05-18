import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/playerSelectionScreen.dart';

import 'playerInfoProvider.dart';

void main() {
  runApp(TicTacToe());
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerInfoProvider>(
      create: (context) => PlayerInfoProvider(),
      child: MaterialApp(
        home: PlayerSelectionScreen(),
        theme: ThemeData(
          canvasColor: Colors.deepOrange[300],
          fontFamily: 'KoHo',
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
