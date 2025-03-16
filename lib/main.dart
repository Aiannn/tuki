import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:tuki_game/components/box_stack.dart';
import 'package:tuki_game/components/terrain.dart';
import 'package:tuki_game/components/tuki.dart';

void main() {
  runApp(GameWidget(game: TukiGame()));
}

class TukiGame extends FlameGame {
  late final Tuki tuki;
  late final Terrain terrain;
  late final BoxStack stack;

  final double terrainSpeed = 100; // Adjust speed here

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
}
