//import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const MaterialApp(home: ColorMatchGame()));

class ColorMatchGame extends StatefulWidget {
  const ColorMatchGame({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ColorMatchGameState createState() => _ColorMatchGameState();
}

class _ColorMatchGameState extends State<ColorMatchGame> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];

  Color targetColor = Colors.redAccent;
  int score = 0;
  bool gameStarted = false;

  @override
  void initState() {
    super.initState();
    startGame(); // Initialize the game when the widget is first built.
  }

  // Function to start the game and generate a target color.
  void startGame() {
    setState(() {
      gameStarted = true;
      targetColor = colors[Random().nextInt(colors.length)];
      score = 0;
    });
    // Add any additional game initialization code here.
  }

  // Function to handle tile taps.
  void handleTileTap(Color tileColor) {
    if (gameStarted) {
      if (tileColor == targetColor) {
        // Correct match - update score and generate a new target color.
        setState(() {
          score++;
          targetColor = colors[Random().nextInt(colors.length)];
        });
      }
      // Add any other game logic here.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Match Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Score: $score',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            gameStarted
                ? const Text(
                    'Match this color:',
                    style: TextStyle(fontSize: 20),
                  )
                : ElevatedButton(
                    onPressed: () {
                      startGame();
                    },
                    child: const Text('Start Game'),
                  ),
            const SizedBox(height: 10),
            Container(
              color: targetColor,
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: colors.map((color) {
                return GestureDetector(
                  onTap: () {
                    handleTileTap(color);
                  },
                  child: Container(
                    color: color,
                    height: 100,
                    width: 100,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
