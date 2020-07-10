import 'dart:math';
import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:mz_flutterapp_deep/widgets/game/enum/flame_enum.dart';
import 'package:mz_flutterapp_deep/widgets/game/flame_Langaw_Game.dart';

import 'flame_monster.dart';

class MoodMonster extends Monster {
  MoodMonster({this.game, ItemRare monsterRare}) : super(game: game) {
    flyingSprite = new List<Sprite>();
    // var sex=game.rnd.nextInt(2);
    // var type=game.rnd.nextInt(10);
    // var mood=game.rnd.nextInt(2)-1;
    // flyingSprite.add(new Sprite('map/${sex}_${type}_$mood.png'));
    // deadSprite=new Sprite('map/${sex}_${type}_2.png');
    var bossUiIndex =
        game.rnd.nextInt(game.resourceManager.monsterSpriteList.length);
    var bossSprite = game.resourceManager.monsterSpriteList[bossUiIndex];
    flyingSprite.add(bossSprite);
    deadSprite = bossSprite;

    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.5, game.tileSize * 1.5);
    rare = monsterRare;
  }
  double get speed => game.tileSize * 3;
  final LangawGame game;
}
