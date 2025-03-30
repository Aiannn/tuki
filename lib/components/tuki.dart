import 'package:flame/components.dart';
import 'package:tuki_game/components/terrain.dart';

class Tuki extends SpriteComponent {
  final Terrain terrain;
  final double yOffset = 2; //Adjust how much above the terrain Tuki stands

  Tuki({required this.terrain});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('player_walk1.png');
    size = Vector2(75, 100); // Adjust based on asset

    // Start Tuki on the terrain surface
    double terrainHeight = terrain.getHeightAt(size.x * 0.3);
    position = Vector2(size.x * 0.3, terrainHeight - size.y + yOffset);
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Keep Tuki standing on the terrain surface
    double terrainHeight = terrain.getHeightAt(position.x);
    position.y = terrainHeight - size.y + yOffset;
  }
}
