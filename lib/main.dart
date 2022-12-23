import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<List<int>> _states = List.generate(
      3, (i) => List.filled(3, 9, growable: false),
      growable: false);
  int _turn = 1;
  bool _isEnd = false;
  String _gameResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (_turn.isOdd) ? 'Player 1' : 'Player 2',
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildNodesForRow(0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildNodesForRow(1),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: buildNodesForRow(2),
            ),
            if (_isEnd)
              Text(
                _gameResult,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (_isEnd)
              ElevatedButton(
                child: const Text('Restart'),
                onPressed: () => restartGame(),
              ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildNodesForRow(int row) {
    final nodes = List.filled(3, const InkWell());

    for (int col = 0; col < 3; col++) {
      nodes[col] = InkWell(
        child: SizedBox(
          height: 100,
          width: 100,
          child: Card(
            color: Colors.grey,
            child: Center(
              child: Text(
                (_states[row][col] == 9) ? '' : _states[row][col].toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          if (_states[row][col] == 9 && !_isEnd) {
            if (_turn.isOdd) {
              setState(() {
                _states[row][col] = 0;
                if (checkWinCondition()) {
                  _isEnd = true;
                  _gameResult = "Player 1 win";
                } else {
                  _turn++;
                }
              });
            } else {
              setState(() {
                _states[row][col] = 1;
                if (checkWinCondition()) {
                  _isEnd = true;
                  _gameResult = "Player 2 win";
                } else {
                  _turn++;
                }
              });
            }

            if (checkDrawCondition()) {
              _isEnd = true;
              _gameResult = "Draw";
            }
          }
        },
      );
    }

    return nodes;
  }

  bool checkWinCondition() {
    int valueToCheck = (_turn.isOdd) ? 0 : 1;

    if (_states[0][0] == valueToCheck &&
        _states[0][1] == valueToCheck &&
        _states[0][2] == valueToCheck) {
      return true;
    } else if (_states[1][0] == valueToCheck &&
        _states[1][1] == valueToCheck &&
        _states[1][2] == valueToCheck) {
      return true;
    } else if (_states[2][0] == valueToCheck &&
        _states[2][1] == valueToCheck &&
        _states[2][2] == valueToCheck) {
      return true;
    } else if (_states[0][0] == valueToCheck &&
        _states[1][0] == valueToCheck &&
        _states[2][0] == valueToCheck) {
      return true;
    } else if (_states[0][1] == valueToCheck &&
        _states[1][1] == valueToCheck &&
        _states[2][1] == valueToCheck) {
      return true;
    } else if (_states[0][2] == valueToCheck &&
        _states[1][2] == valueToCheck &&
        _states[2][2] == valueToCheck) {
      return true;
    } else if (_states[0][0] == valueToCheck &&
        _states[1][1] == valueToCheck &&
        _states[2][2] == valueToCheck) {
      return true;
    } else if (_states[0][2] == valueToCheck &&
        _states[1][1] == valueToCheck &&
        _states[2][0] == valueToCheck) {
      return true;
    }

    return false;
  }

  bool checkDrawCondition() {
    return _turn == 10;
  }

  void restartGame() {
    setState(() {
      _states = List.generate(3, (i) => List.filled(3, 9, growable: false),
          growable: false);
      _turn = 1;
      _isEnd = false;
    });
  }
}
