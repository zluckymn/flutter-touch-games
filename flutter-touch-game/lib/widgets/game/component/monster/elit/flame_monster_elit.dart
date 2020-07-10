import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:mz_flutterapp_deep/widgets/game/component/monster/skills/flame_skill.dart';
import 'package:mz_flutterapp_deep/widgets/game/component/ui/flame_hit_tip_warning.dart';
import 'package:mz_flutterapp_deep/widgets/game/enum/flame_enum.dart';
import 'package:mz_flutterapp_deep/widgets/game/flame_Langaw_Game.dart';
import '../flame_monster.dart';

//elitMonster 具有击杀条件默认连击 life数
//点击后触发子弹时间
//拥有更强的属性，掉落特殊道具
class ElitMonster extends Monster {
  ElitMonster({this.game, ItemRare monsterRare}) : super(game: game) {
    flyingSprite = new List<Sprite>();
    // var sex = game.rnd.nextInt(2);
    // var type = game.rnd.nextInt(10);
    // var mood = game.rnd.nextInt(2) - 1;
    // flyingSprite.add(new Sprite('map/${sex}_${type}_$mood.png'));
    // deadSprite = new Sprite('map/${sex}_${type}_2.png');
    var bossUiIndex =
        game.rnd.nextInt(game.resourceManager.monsterSpriteList.length);
    var bossSprite = game.resourceManager.monsterSpriteList[bossUiIndex];
    flyingSprite.add(bossSprite);
    deadSprite = bossSprite;
    flyRect = Rect.fromLTWH(x, y, game.tileSize * 1.9, game.tileSize * 1.9);
    rare = monsterRare;
  }
  double monsterSpeedEnhence = 3.7;
  double get speed =>
      game.tileSize * monsterSpeedEnhence * game.towerlevelEnhence;
  int hits = 0;
  int get initHp => (5 * Game_HP_Unit * game.towerlevelEnhence).toInt();
  int lives = 1;
  bool canKill = false;
  double speedEnhence = 1; //速度偏移
  double initSpeedEnhence = 1;
  final LangawGame game;
  bool hasCallout = false; //不会超时
  HitTipWarning hitTipWarning; //boss技能提示
  bool isTipWarning = false;
  bool hasHp = true;
  //击杀后特效
  @override
  void onHitEffect() async {
    game.monsterKilled(this);
  }

  //击杀后特效
  @override
  bool isMatchDefeatCondition() {
    return canKill;
  }

  //获取基础得分
  @override
  getScore() {
    return 10;
  }

  //需要打击2次才能死亡
  @override
  void onTapStart() {
    if (curHp <= 0) {
      canKill = true;
      game.audioplayers.successElitKill();
    } else {
      game.audioplayers.successHit(); //连打音效
    }
    game.combo++; //攒连击数
  }
}
