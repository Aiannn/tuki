import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tuki_game/components/box_stack.dart';
import 'package:tuki_game/components/game_over_overlay.dart';
import 'package:tuki_game/components/terrain.dart';
import 'package:tuki_game/components/tuki.dart';

void main() {
  runApp(GameWidget(
    game: TukiGame(),
    overlayBuilderMap: {
      'Game Over': (context, game) => GameOverOverlay(game: game as TukiGame),
    },
  ));
}

class TukiGame extends FlameGame with TapDetector {
  late final Tuki tuki;
  late final Terrain terrain;
  late final BoxStack stack;

  final double terrainSpeed = 100; // Adjust speed here
  bool isGameOver = false;

  @override
  Future<void> onLoad() async {
    camera.viewfinder.anchor = Anchor.topLeft;

    terrain = Terrain(terrainSpeed);
    tuki = Tuki();
    stack = BoxStack(tuki);

    add(terrain);
    add(tuki);
    add(stack);
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (isGameOver) {
      restartGame();
    } else {
      stack.tiltClockwise(); // Tell the stack to tilt clockwise when tapped
    }
  }

  void onGameOver() {
    isGameOver = true;
    terrain.stopMoving(); // Stop terrain movement
    overlays.add('Game Over'); // Show game over overlay
  }

  void restartGame() {
    isGameOver = false;
    overlays.remove('Game Over'); // Remove game over overlay

    stack.resetStack(); // Reset stack tilt
    terrain.resumeMoving(); // Resume terrain movement
  }
}
