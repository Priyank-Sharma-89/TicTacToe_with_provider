import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_toe/gameBoardScreen.dart';
import 'package:tic_tac_toe/playerInfoProvider.dart';

class PlayerSelectionScreen extends StatefulWidget {
  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData getTheme = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<PlayerInfoProvider>(
          builder: (context, playerInfo, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      height: screenSize.height * 0.3,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Player 1 : ',
                                  style: getTheme.textTheme.headline5,
                                ),
                                Container(
                                  width: screenSize.width * 0.5,
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    maxLength: 15,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your name',
                                    ),
                                    style: getTheme.textTheme.headline6,
                                    onFieldSubmitted: (name) {
                                      playerInfo.playerOneName = name;
                                      print(playerInfo.getPlayerOneName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Player 2 : ',
                                  style: getTheme.textTheme.headline5,
                                ),
                                Container(
                                  width: screenSize.width * 0.5,
                                  child: TextFormField(
                                    textCapitalization:
                                        TextCapitalization.words,
                                    keyboardType: TextInputType.name,
                                    maxLength: 15,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    decoration: InputDecoration(
                                      hintText: 'Enter your name',
                                    ),
                                    style: getTheme.textTheme.headline6,
                                    onFieldSubmitted: (name) {
                                      playerInfo.playerTwoName = name;
                                      print(playerInfo.getPlayerTwoName);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Text(
                          'Player 1 Choose your side',
                          style: getTheme.textTheme.headline5,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Ink(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 35),
                                  child: Text(
                                    'X',
                                    style: getTheme.textTheme.headline4
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: playerInfo.getPlayerOneSide == 'X'
                                      ? Colors.greenAccent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onTap: () {
                                playerInfo.playerOneSide = 'X';
                                playerInfo.playerTwoSide = 'O';
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            InkWell(
                              child: Ink(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 35),
                                  child: Text(
                                    'O',
                                    style: getTheme.textTheme.headline4
                                        .copyWith(color: Colors.black),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: playerInfo.getPlayerOneSide == 'O'
                                      ? Colors.greenAccent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onTap: () {
                                playerInfo.playerOneSide = 'O';
                                playerInfo.playerTwoSide = 'X';
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Text(
                            "Let's Play!",
                            style: getTheme.textTheme.headline6,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GameBoardScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
