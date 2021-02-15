import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe/custom_dialog.dart';
import 'package:tic_tac_toe/game_btn.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var HUMAN_PLAYER = 1;
  var COMPUTER_PLAYER = 2;

  List<GameBtn> buttonList;

  var player1;
  var player2;
  var activePlayer;

  @override
  void initState() {
    buttonList = doInit();
    super.initState();
  }

  List<GameBtn> doInit() {
    player1 = [];
    player2 = [];
    activePlayer = 1;
    var gameButtons = <GameBtn>[
      new GameBtn(id: 1),
      new GameBtn(id: 2),
      new GameBtn(id: 3),
      new GameBtn(id: 4),
      new GameBtn(id: 5),
      new GameBtn(id: 6),
      new GameBtn(id: 7),
      new GameBtn(id: 8),
      new GameBtn(id: 9),
    ];
    return gameButtons;
  }

  void playGame(GameBtn gb) {
    setState(() {
      if (activePlayer == HUMAN_PLAYER) {
        gb.text = 'x';
        gb.bg = Colors.redAccent;
        activePlayer = COMPUTER_PLAYER;
        player1.add(gb.id);
      } else {
        gb.text = '0';
        gb.bg = Colors.black;
        activePlayer = HUMAN_PLAYER;
        player2.add(gb.id);
      }
      gb.enabled = false;
      int winner = checkWinner();
      if (winner == -1) {
        if (buttonList.every((p) => p.text != "")) {
          showDialog(
            context: context,
            builder: (_) => new CustomDialog("Game tied",
                "Press the reset button to start again", resetGame),
          );
        } else {
          activePlayer == COMPUTER_PLAYER ? autoPlay() : null;
        }
      }
    });
  }

  void autoPlay() {
    var emptyCells = [];
    List list = List.generate(9, (i) => i + 1);
    for (var cellID in list) {
      if ((!player1.contains(cellID) && !player2.contains(cellID))) {
        emptyCells.add(cellID);
      }
    }
    print("Empty cells : ${emptyCells}");

    var r = new Random();
    var randIndex = r.nextInt(emptyCells.length - 1);
    var cellID = emptyCells[randIndex];
    int i = buttonList.indexWhere((p) => p.id == cellID);
    print("selected button from computer move at $i");
    playGame(buttonList[i]);
  }

  int checkWinner() {
    var winner = -1;

    //row1 player1
    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    }
    //row1 player2
    if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
      winner = 2;
    }
    //row2 player1
    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    }
    //row2 player2
    if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
      winner = 2;
    }
    //row3 player1
    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    }
    //row3 player2
    if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
      winner = 2;
    }

    //col1 player1
    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    }
    //col1 player2
    if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
      winner = 2;
    }
    //col2 player1
    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    }
    //col2 player2
    if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
      winner = 2;
    }

    //col3 player1
    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    }
    //col3 player2
    if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
      winner = 2;
    }

    //diagonal1 player1
    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    }
    //diagonal1 player2
    if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
      winner = 2;
    }
    //diagonal2 player1
    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    }
    //diagonal2 player2
    if (player2.contains(3) && player2.contains(5) && player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 1 won",
                "Press the reset button to start again", resetGame));
      } else {
        showDialog(
            context: context,
            builder: (_) => new CustomDialog("Player 2 won",
                "Press the reset button to start again", resetGame));
      }
    }
    return winner;
  }

  void resetGame() {
    if (Navigator.canPop(context)) Navigator.pop(context);
    setState(() {
      buttonList = doInit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 9.0,
                crossAxisSpacing: 9.0,
              ),
              itemCount: buttonList.length,
              itemBuilder: (context, i) => new SizedBox(
                width: 100,
                height: 100,
                child: new RaisedButton(
                  padding: EdgeInsets.all(8.0),
                  onPressed: buttonList[i].enabled
                      ? () => playGame(buttonList[i])
                      : null,
                  child: Text(
                    buttonList[i].text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  color: buttonList[i].bg,
                  disabledColor: buttonList[i].bg,
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: resetGame,
            child: Text(
              'Reset',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
