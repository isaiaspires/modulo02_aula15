import 'package:flutter/material.dart';

class QuantasPalavras extends StatelessWidget {
  const QuantasPalavras({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WordGamesScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WordGamesScreen extends StatefulWidget {
  const WordGamesScreen({Key? key}) : super(key: key);

  @override
  State<WordGamesScreen> createState() => _WordGamesScreenState();
}

class _WordGamesScreenState extends State<WordGamesScreen> {
  var gameRunning = false;
  var timerSeconds = 30;
  var inputword = "";
  var countWord = 3;
  final words = [
    "manga",
    "laranja",
    "banana",
    "pera",
    "caju",
    "uva",
    "mamao",
    "acerola",
    "abacaxi",
    "goiaba"
  ];

  final wordController = TextEditingController();

  void startGame() async {
    setState(() {
      gameRunning = true;
      timerSeconds = 30;
      countWord = 3;
    });
    for (var i = timerSeconds; i >= 0; i--) {
      if (countWord == 0) break;
      setState(() => timerSeconds = i);
      await Future.delayed(const Duration(seconds: 1));
    }
    setState(() => gameRunning = false);
  }

  void sendWord() {
    final messenger = ScaffoldMessenger.of(context);
    final word = wordController.text;
    final hasWord = words.contains(word.toLowerCase());
    wordController.clear();
    if (!hasWord) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Palavra Incorreta"),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.red,
        ),
      );
      return;
    } else {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Palavra encontrada"),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.green,
        ),
      );

      countWord -= 1;

      if (countWord == 0) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            content: Text("Você encontrou três palavras."),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final titleText = gameRunning ? '00:$timerSeconds' : 'Quantas Palavras?';
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: wordController,
              
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              child: const Text('Enviar'),
              onPressed: gameRunning ? sendWord : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              child: const Text('Start Game'),
              onPressed: !gameRunning ? startGame : null,
              style: ElevatedButton.styleFrom(
                primary: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
