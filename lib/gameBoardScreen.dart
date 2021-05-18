import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/playerInfoProvider.dart';

class GameBoardScreen extends StatefulWidget {
  @override
  _GameBoardScreenState createState() => _GameBoardScreenState();
}

class _GameBoardScreenState extends State<GameBoardScreen> {
  String firstPlayer, secondPlayer, firstSide, secondSide, currentMove;
  var cellBlocks = List.filled(9, '');

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
    print('firstSide --- $firstSide');
    print('secondSide --- $secondSide');
  }

  playerMove(index) {
    if (currentMove == null) {
      currentMove = firstSide;
    } else if (currentMove == firstSide) {
      currentMove = secondSide;
    } else if (currentMove == secondSide) {
      currentMove = firstSide;
    }
    cellBlocks[index] = currentMove;
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
                      RichText(
                        text: TextSpan(
                            text: '$firstPlayer [ $firstSide ]',
                            style: getTheme.textTheme.headline5,
                            children: [
                              TextSpan(
                                text: '   vs   ',
                                style: getTheme.textTheme.subtitle1
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: '$secondPlayer [ $secondSide ]',
                                style: getTheme.textTheme.headline5,
                              ),
                            ]),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                      .copyWith(fontWeight: FontWeight.bold),
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
