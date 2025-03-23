import 'package:flutter/material.dart';
import 'package:tuki_game/main.dart';

class GameOverOverlay extends StatelessWidget {
  final TukiGame game;

  const GameOverOverlay({required this.game, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: game.restartGame,
        child: const Text("Restart Game"),
      ),
    );
  }
}
