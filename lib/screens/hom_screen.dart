import 'dart:ffi';

import 'package:flutter/material.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool isTurnO = true;
  List<String> xOrolist = ['', '', '', '', '', '', '', '', ''];

  int filledBoxes = 0;
  bool gameHasResult = false;

  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        title: Center(child: Text('Tic Tac Toy')),
        actions: [
          IconButton(
              onPressed: () {
                clearGame();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: SafeArea(
          child: Column(
        children: [
          getScoreBord(),
          SizedBox(
            height: 10,
          ),
          getResultButton(),
          grideview(),
          getTurn(),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }

  Widget getTurn() {
    return Text(isTurnO ? 'turn O' : 'turn X',
        style: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold));
  }

  void taped(int index) {
    setState(() {
      if (gameHasResult) {
        return;
      }
      if (isTurnO && xOrolist[index] == '') {
        xOrolist[index] = 'O';
        filledBoxes = filledBoxes + 1;
        isTurnO = false;
      }
      if (!isTurnO && xOrolist[index] == '') {
        xOrolist[index] = 'X';
        filledBoxes = filledBoxes + 1;
        isTurnO = true;
      }
      chekWinner();
      print('$index');
    });
  }

  void chekWinner() {
    if (xOrolist[0] == xOrolist[1] &&
        xOrolist[0] == xOrolist[2] &&
        xOrolist[0] != '') {
      setResult(xOrolist[0], 'winner is ' + xOrolist[0]);
      return;
    }

    if (xOrolist[3] == xOrolist[4] &&
        xOrolist[3] == xOrolist[5] &&
        xOrolist[3] != '') {
      setResult(xOrolist[3], 'winner is ' + xOrolist[3]);

      return;
    }

    if (xOrolist[6] == xOrolist[7] &&
        xOrolist[6] == xOrolist[8] &&
        xOrolist[6] != '') {
      setResult(xOrolist[6], 'winner is ' + xOrolist[6]);

      return;
    }

    if (xOrolist[0] == xOrolist[3] &&
        xOrolist[0] == xOrolist[6] &&
        xOrolist[0] != '') {
      setResult(xOrolist[0], 'winner is ' + xOrolist[0]);
      return;
    }

    if (xOrolist[1] == xOrolist[4] &&
        xOrolist[1] == xOrolist[7] &&
        xOrolist[1] != '') {
      setResult(xOrolist[1], 'winner is ' + xOrolist[1]);
      return;
    }

    if (xOrolist[2] == xOrolist[5] &&
        xOrolist[2] == xOrolist[8] &&
        xOrolist[2] != '') {
      setResult(xOrolist[2], 'winner is ' + xOrolist[2]);
      return;
    }

    if (xOrolist[0] == xOrolist[4] &&
        xOrolist[0] == xOrolist[8] &&
        xOrolist[0] != '') {
      setResult(xOrolist[0], 'winner is ' + xOrolist[0]);
      return;
    }

    if (xOrolist[2] == xOrolist[4] &&
        xOrolist[2] == xOrolist[6] &&
        xOrolist[2] != '') {
      setResult(xOrolist[2], 'winner is ' + xOrolist[2]);
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'Draw');
    }
  }

  Widget getScoreBord() {
    return Row(children: [
      Expanded(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '$scoreO',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Text('player O',
                    style: TextStyle(color: Colors.white, fontSize: 26)))
          ],
        ),
      ),
      Expanded(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '$scoreX',
                style: TextStyle(color: Colors.white, fontSize: 26),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8),
                child: Text('player X',
                    style: TextStyle(color: Colors.white, fontSize: 26)))
          ],
        ),
      ),
    ]);
  }

  Widget grideview() {
    return Expanded(
      child: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              taped(index);
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text(xOrolist[index],
                    style: TextStyle(
                      fontSize: 50,
                      color: xOrolist[index] == 'X' ? Colors.white : Colors.red,
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  void setResult(String winner, String title) {
    setState(() {
      if (winner == 'X') {
        scoreX = scoreX + 1;
      } else if (winner == "O") {
        scoreO = scoreO + 1;
      } else {
        scoreO = scoreO + 1;
        scoreX = scoreX + 1;
      }
      gameHasResult = true;
      winnerTitle = title;
    });
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.white,
          side: BorderSide(color: Colors.white, width: 2),
        ),
        onPressed: () {
          setState(() {
            gameHasResult = false;
            clearGame();
          });
        },
        child: Text(
          '$winnerTitle, play again!',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrolist.length; i++) {
        xOrolist[i] = '';
      }
    });

    filledBoxes = 0;
  }
}
