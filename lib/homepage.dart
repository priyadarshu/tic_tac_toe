import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_btn.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      if (activePlayer == 1) {
        gb.text = 'x';
        gb.bg = Colors.redAccent;
        activePlayer = 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tic Tac Toe"),
        centerTitle: true,
      ),
      body: GridView.builder(
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
            onPressed:
                buttonList[i].enabled ? () => playGame(buttonList[i]) : null,
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
    );
  }
}
