import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:mz_flutterapp_deep/widgets/game/controler/bgm.dart';
import 'package:mz_flutterapp_deep/widgets/game/enum/flame_enum.dart';
import 'package:synchronized/synchronized.dart';

import '../flame_Langaw_Game.dart';

///主要用于资源管理
class ResourceManager {
  final LangawGame game;
  // AudioPlayer finishBGM;
  List<String> bgmList = new List<String>();
  List<String> bgmStageClearList = new List<String>();
  List<String> touchSoundList = new List<String>();
  List<String> boundSpriteList = new List<String>();
  List<String> hitEffectSpriteList = new List<String>(); //打击效果
  List<String> comboRedSpriteList = new List<String>(); //hits效果
  List<String> comboBlueSpriteList = new List<String>(); //hits效果
  List<String> evaluationSpriteList = new List<String>(); //评价得分
  List<String> lightSpriteList = new List<String>(); //高光背景
  List<String> hitsSoundList = new List<String>(); //连打
  List<String> buffSpriteList = new List<String>(); //buff 状态
  List<String> finishEffectSpriteList = new List<String>(); //qte终结 状态
  List<Sprite> monsterSpriteList = new List<Sprite>();
  List<Sprite> monsterEmoticonSpriteList = new List<Sprite>();
  List<String> lifeSpriteList = new List<String>();
  ResourceManager(this.game);
  Future loadResource() async {
    loadImg();
    loadAuido();
  }

  //加载资源
  Future loadImg() async {
    //背景图片
    var bgList = new List<String>();
    // for (var sex = 0; sex <= 1; sex++) {
    //   for (var type = 0; type <= 9; type++) {
    //     bgList.add("map/${sex}_${type}_0.png");
    //     bgList.add("map/${sex}_${type}_1.png");
    //     bgList.add("map/${sex}_${type}_-1.png");
    //     bgList.add("map/${sex}_${type}_2.png");
    //   }
    // }
    //物品获得图片
    boundSpriteList = new List<String>();
    for (var index = 0; index <= 3; index++) {
      // boundSpriteList.add("game/itemSprite_$index.png");
      boundSpriteList.add("game/fx_$index.png");
    }

    //打击效果
    hitEffectSpriteList = new List<String>();
    for (var index = 1; index <= 6; index++) {
      hitEffectSpriteList.add("game/hitfx_normal_0$index.png");
    }
    //combo特效
    comboBlueSpriteList = new List<String>();
    for (var index = 1; index <= 6; index++) {
      comboBlueSpriteList.add("game/fx_combo_blue_$index.png");
    }
    //combo特效
    comboRedSpriteList = new List<String>();
    for (var index = 1; index <= 6; index++) {
      comboRedSpriteList.add("game/fx_combo_red_$index.png");
    }
    //最终评分
    evaluationSpriteList = new List<String>();
    for (var index = 1; index <= 7; index++) {
      evaluationSpriteList.add("game/Grade_$index.png");
    }

    lightSpriteList = new List<String>();
    for (var index = 1; index <= 3; index++) {
      lightSpriteList.add("game/ui_light_0$index.png");
    }
    //从buff枚举中提取抓鬼你太
    for (var buffItem in GameBuffType.values) {
      var buffStr = GameEnumHelper.getStringFromEnum(buffItem);
      buffSpriteList.add('game/buff/$buffStr.png');
    }

    //终结爆炸效果
    finishEffectSpriteList.add("game/boom_effect.png");
    //生命
    for (var index = 5; index <= 10; index++) {
      lifeSpriteList.add("game/mood_$index.png");
    }

    var allImglist = new List<String>();
    allImglist.addAll(bgList);
    allImglist.addAll(evaluationSpriteList);
    allImglist.addAll(boundSpriteList);
    allImglist.addAll(hitEffectSpriteList);
    allImglist.addAll(comboRedSpriteList);
    allImglist.addAll(comboBlueSpriteList);
    allImglist.addAll(lightSpriteList);

    allImglist.addAll(buffSpriteList); //添加buff
    allImglist.addAll(<String>[
      'game/Fever.png',
      'game/backyard_rank.png',
      'game/item_fullScreenAttect.png', // 全屏
      'game/item_freezen.png', //冻结
      'game/backyard.png',
      'game/ui/callout.png',
      'game/TreasureChest_1.png',
      'game/ui_boss_warning_cn.png',
      'game/Hand.png',
      'game/ui_boss_profile.png',
      'game/ui_boss_warning_sign.png',
      'game/ui_bosstxt_B.png',
      'game/ui_bosstxt_O.png',
      'game/ui_touchscreen_icon_01.png',
      'game/ui_touchscreen_icon_02.png',
      'game/HitsBase.png',
      'game/hp_black_small.png', //血条
      'game/hp_green_small.png', //血条
      'game/hp_red_small.png', //血条
      'game/hp_yellow_small.png', //血条
      'game/loading_bar.png', //技能读条
      'game/loading_bar_bg.png',
      'game/loading_bar_fever.png',
      'game/expert_bar_bg.png', //经验栏
      'game/expert_bar_yellow.png', //经验栏
      'game/item_heart.png',
      'game/item_poison.png', //毒状态
      'game/item_random.png', //随机
      'game/item_powerup.png', //力量up
      'game/ui_boss.png',
      'game/fx_flash.png', //一闪
      'game/fx_frozzen.png', //冰冻
      'game/fx_catch.png', //禁锢
      'game/ui_boss_collection.png', //bossUI
      'game/emoticon.png', //表情
      'game/emoticon_collection.png', //随机表情
      'game/fx_hit_miss.png', //miss殿中
      'game/item_bloodrush_skill.png',
    ]);
    Flame.images.loadAll(allImglist);
    loadBossSpriteList();
    loadEmoticonSpriteList();
  }

  //加载bossUI
  Future loadBossSpriteList() async {
    double width = 30;
    double height = 32;
    for (var index = 0; index <= 13; index++) {
      var x = index * width;
      monsterSpriteList.add(Sprite('game/ui_boss_collection.png',
          height: height, width: width, x: x, y: 0));
    }
  }

  //加载bossUI表情
  Future loadEmoticonSpriteList() async {
    double width = 43;
    double height = 60;
    for (var index = 0; index < 13; index++) {
      var x = index * width;
      monsterEmoticonSpriteList.add(Sprite('game/emoticon_collection.png',
          height: height, width: width, x: x, y: 0));
    }
  }

  //加载音效
  Future loadAuido() async {
    bgmList.addAll([
      // 'game/bgm/bgm_god.wav',
      //  'game/bgm/bgm_lobby.wav',
      // 'game/bgm/bgm_day.wav',
      'game/bgm/sea.wav',
      'game/bgm/river.ogg',
      // 'game/bgm/bgm_night.wav',
      //  'game/bgm/bgm_welcome.wav',
      // 'game/bgm/bgm-lukyanov.wav',
    ]);
    bgmStageClearList.addAll([
      'game/sfx/sfx_stage_clear_0.wav',
      'game/sfx/sfx_stage_clear_1.wav',
      'game/sfx/sfx_stage_clear_2.wav',
      'game/sfx/sfx_stage_clear_3.wav',
    ]);
    hitsSoundList.addAll([
      'game/sfx/sfx_hit_1.wav',
      'game/sfx/sfx_hit_2.wav',
      'game/sfx/sfx_hit_3.wav',
    ]);
    var allAudioList = new List<String>();
    allAudioList.addAll(bgmList);
    allAudioList.addAll(bgmStageClearList);
    allAudioList.addAll(hitsSoundList);
    allAudioList.addAll(<String>[
      'game/sfx/sfx_button.wav',
      'game/sfx/sfx_button_back.wav',
      'game/sfx/sfx_button_cancel.wav',
      'game/sfx/sfx_button_confirm.wav',
      'game/sfx/sfx_button_switch.wav',
      'game/sfx/sfx_cha_levelup.wav',
      'game/sfx/sfx_getItem_1.wav',
      'game/sfx/sfx_getItem_2.wav',
      'game/sfx/sfx_long_press.wav',
      'game/sfx/sfx_long_press_up.wav',
      'game/sfx/sfx_loseHit.wav',
      'game/sfx/sfx_monster_die.wav',
      'game/sfx/sfx_refresh.wav',
      'game/sfx/sfx_water_appear_0.wav',
      'game/sfx/sfx_water_appear_1.wav',
      'game/sfx/sfx_ice_blow.wav',
      'game/sfx/sfx_warning.wav',
      'game/sfx/sfx_shield.wav',
      'game/sfx/sfx_shield_crash.wav',
      'game/sfx/sfx_state_stun.wav',
      'game/sfx/sfx_skill_start.wav',
      'game/sfx/sfx_state_heal.wav',
      'game/sfx/sfx_state_poison.wav',
      'game/sfx/sfx_state_powerup.wav',
      'game/sfx/sfx_unlock.wav',
      'game/sfx/sfx_state_bleeding.wav',
    ]);
    //Flame.audio.disableLog();//
    Flame.audio.loadAll(allAudioList);
    await GameBGM.preload();
    GameBGM.play();
  }
}
