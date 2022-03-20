import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modulo02_aula15/Async_Bet/async_bet_line_widget.dart';

import 'lines.dart';

const lineHeight = 900.0;

class AsyncBetScreen extends StatefulWidget {
  const AsyncBetScreen({Key? key}) : super(key: key);

  @override
  State<AsyncBetScreen> createState() => _AsyncBetScreenState();
}

class _AsyncBetScreenState extends State<AsyncBetScreen> {
  var lineRed = 0;
  void setLineRed(int value) => setState(() => lineRed = value);
  var linePurple = 0;
  void setLinePurple(int value) => setState(() => linePurple = value);
  var lineBlue = 0;
  void setLineBlue(int value) => setState(() => lineBlue = value);

  bool get notWinner => lineBlue < 100 && linePurple < 100 && lineRed < 100;

  StreamSubscription? subscription;

  Future<String> runGame() async {
    setLineBlue(0);
    setLinePurple(0);
    setLineRed(0);

    final random = Random();
    while (notWinner) {
      setLineBlue(lineBlue + random.nextInt(10));
      setLinePurple(linePurple + random.nextInt(10));
      setLineRed(lineRed + random.nextInt(10));
      await Future.delayed(const Duration(milliseconds: 200));
    }

    if (lineRed >= 100) return 'Vemelho';
    if (lineBlue >= 100) return 'Azul';
    if (linePurple >= 100) return 'Roxo';
    return "";
  }

  final lines = Lines();

  Stream<Lines> runLines() async* {
    lines.clear();
    yield lines;
    final random = Random();
    while (lines.notWinner) {
      lines.incrementBlue(random.nextInt(10));
      lines.incrementPurple(random.nextInt(10));
      lines.incrementRed(random.nextInt(10));
      yield lines;
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }

  void onStart() {
    subscription = runLines().listen(
      (lines) {
        setLineBlue(lines.blue);
        setLinePurple(lines.purple);
        setLineRed(lines.red);

        if (lines.winner != null) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text('${lines.winner!} venceu!'),
            ),
          );
        }
      },
      onDone: () {},
    );
  }

  void onCancel() {
    subscription?.cancel();
    showDialog(
      context: context,
      builder: (_) => const AlertDialog(
        content: Text('Cancelou!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AsyncBet'),
        backgroundColor: Colors.green.shade900,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onStart,
              child: Text(
                'start',
                style: TextStyle(color: Colors.green.shade900),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: onCancel,
              child: Text(
                'stop',
                style: TextStyle(color: Colors.green.shade900),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AsyncLineWidget(
              height: lineHeight,
              color: Colors.red,
              progress: lineRed,
            ),
            AsyncLineWidget(
              height: lineHeight,
              color: Colors.deepPurple,
              progress: linePurple,
            ),
            AsyncLineWidget(
              height: lineHeight,
              color: Colors.blue,
              progress: lineBlue,
            ),
          ],
        ),
      ),
    );
  }
}
