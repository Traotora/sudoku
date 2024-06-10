//traotora 2024 

import 'package:flutter/material.dart';

void main() => runApp(SudokuApp());

class SudokuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sudoku',
      home: SudokuScreen(),
    );
  }
}

class SudokuScreen extends StatefulWidget {
  @override
  _SudokuScreenState createState() => _SudokuScreenState();
}

class _SudokuScreenState extends State<SudokuScreen> {
  List<List<int>> board = [
    [5, 3, 0, 0, 7, 0, 0, 0, 0],
    [6, 0, 0, 1, 9, 5, 0, 0, 0],
    [0, 9, 8, 0, 0, 0, 0, 6, 0],
    [8, 0, 0, 0, 6, 0, 0, 0, 3],
    [4, 0, 0, 8, 0, 3, 0, 0, 1],
    [7, 0, 0, 0, 2, 0, 0, 0, 6],
    [0, 6, 0, 0, 0, 0, 2, 8, 0],
    [0, 0, 0, 4, 1, 9, 0, 0, 5],
    [0, 0, 0, 0, 8, 0, 0, 7, 9],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sudoku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            buildBoard(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: solveSudoku,
              child: Text('Solve Sudoku'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoard() {
    return Column(
      children: List.generate(9, (i) {
        return Row(
          children: List.generate(9, (j) {
            return buildCell(i, j);
          }),
        );
      }),
    );
  }

  Widget buildCell(int i, int j) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
      ),
      child: Center(
        child: Text(
          board[i][j] != 0 ? board[i][j].toString() : '',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  void solveSudoku() {
    if (solve(board)) {
      setState(() {});
    }
  }

  bool solve(List<List<int>> board) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board[i][j] == 0) {
          for (int num = 1; num <= 9; num++) {
            if (isSafe(board, i, j, num)) {
              board[i][j] = num;
              if (solve(board)) {
                return true;
              }
              board[i][j] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  bool isSafe(List<List<int>> board, int row, int col, int num) {
    for (int i = 0; i < 9; i++) {
      if (board[row][i] == num || board[i][col] == num || board[row - row % 3 + i ~/ 3][col - col % 3 + i % 3] == num) {
        return false;
      }
    }
    return true;
  }
}
