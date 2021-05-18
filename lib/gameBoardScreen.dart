import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/playerInfoProvider.dart';
import 'package:tic_tac_toe/playerSelectionScreen.dart';

class GameBoardScreen extends StatefulWidget {
  @override
  _GameBoardScreenState createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  String firstPlayer,
      secondPlayer,
      firstSide,
      secondSide,
      currentMove,
      currentPlayer;
  int moveCounter = 1;
  var cellBlocks = List.filled(9, '');

  var winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ];

  @override
  void initState() {
    super.initState();
    firstPlayer = Provider.of<PlayerInfoProvider>(context, listen: false)
        .getPlayerOneName;
    secondPlayer = Provider.of<PlayerInfoProvider>(context, listen: false)
        .getPlayerTwoName;
    firstSide = Provider.of<PlayerInfoProvider>(context, listen: false)
        .getPlayerOneSide;
    secondSide = Provider.of<PlayerInfoProvider>(context, listen: false)
        .getPlayerTwoSide;
    currentPlayer = firstPlayer;
  }

  playerMove(index) {
    if (currentMove == null) {
      currentMove = firstSide;
    } else if (currentMove == firstSide) {
      currentMove = secondSide;
    } else if (currentMove == secondSide) {
      currentMove = firstSide;
    }
    if (cellBlocks[index] == '') {
      cellBlocks[index] = currentMove;

      for (var i = 0; i < winningConditions.length; i++) {
        String symbolEntered = cellBlocks[index];
        if (symbolEntered == cellBlocks[winningConditions[i][0]] &&
            symbolEntered == cellBlocks[winningConditions[i][1]] &&
            symbolEntered == cellBlocks[winningConditions[i][2]]) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                "$currentPlayer Wins!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              content: Image.asset('assets/images/winner.png'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    // Navigator.of(ctx).pop();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => PlayerSelectionScreen()),
                        (Route<dynamic> route) => false);
                  },
                  child: Text(
                    "Restart Game",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
          );
          // isGameOver = true;
          break;
        }
      }

      if (moveCounter == 9) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text("Game Draw"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // Navigator.of(ctx).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => PlayerSelectionScreen()),
                      (Route<dynamic> route) => false);
                },
                child: Text("Restart Game"),
              )
            ],
          ),
        );
      }
      moveCounter++;
      if (currentPlayer == firstPlayer) {
        currentPlayer = secondPlayer;
      } else if (currentPlayer == secondPlayer) {
        currentPlayer = firstPlayer;
      }
    } else
      return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData getTheme = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: (firstPlayer == null || secondPlayer == null)
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ))
            : Center(
                child: Container(
                  width: double.infinity,
                  height: screenSize.height * 0.85,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            '$firstPlayer [ $firstSide ]',
                            style: getTheme.textTheme.headline6,
                          ),
                          Text(
                            'vs',
                            style: getTheme.textTheme.headline6,
                          ),
                          Text(
                            '$secondPlayer [ $secondSide ]',
                            style: getTheme.textTheme.headline6,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Current Player',
                                  style: getTheme.textTheme.subtitle2,
                                ),
                                Text(
                                  currentPlayer,
                                  style: getTheme.textTheme.subtitle2,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 2.0,
                                mainAxisSpacing: 2.0,
                              ),
                              itemCount: cellBlocks.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  child: Container(
                                    child: Center(
                                      child: Text(
                                        cellBlocks[index],
                                        style: getTheme.textTheme.headline4
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  onTap: () {
                                    playerMove(index);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 30),
                            child: Text(
                              "Quit",
                              style: getTheme.textTheme.headline6.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
