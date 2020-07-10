import 'dart:ui';
import 'package:flame/sprite.dart';

import '../../flame_Langaw_Game.dart';

class GameLifeDisplay {
  final LangawGame game;

  List<Rect> rects;
  Sprite titleSprite;
  List<Sprite> lifeSpriteList; //动画对象
  double lightSpriteIndex = 0; //怪物当前动画帧
  GameLifeDisplay(this.game, {double width, double height}) {
    if (width == null) {
      width = game.tileSize * 0.8;
    }
    if (height == null) {
      height = game.tileSize;
    }
    rects = new List<Rect>();
    for (var lifeIndex = 0; lifeIndex < game.initLife; lifeIndex++) {
      var titleRect = Rect.fromLTWH(
        game.screenSize.width -
            game.tileSize * 1.25 -
            ((lifeIndex + 1) * width),
        game.tileSize * 0.6,
        width,
        height,
      );
      rects.add(titleRect);
    }
    lifeSpriteList = new List<Sprite>();
    var globalLifeSprite = game.resourceManager.lifeSpriteList;
    for (var lifeImg in globalLifeSprite) {
      lifeSpriteList.add(new Sprite(lifeImg));
    }
  }
  void render(Canvas c) {
    return;
    if (rects == null) return;
    titleSprite = lifeSpriteList[lightSpriteIndex.toInt()];
    for (var lifeRect in rects) {
      titleSprite.renderRect(c, lifeRect);
    }
  }

  void update(double t) {
    return;
    lightSpriteIndex += 20 * t / 5;
    if (lightSpriteIndex >= lifeSpriteList.length) {
      lightSpriteIndex = 0;
    }
  }

  //失去生命
  void loseLife() {
    if (rects.length > 0) {
      rects.removeLast();
    }
  }
}
