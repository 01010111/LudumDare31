package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSort;
import flixel.util.FlxTimer;
import items.GoldenHelm;
import items.Mulberry;
import items.RustySword;
import people.Granny;
import people.King;
import people.Knight;
import people.Mage;
import things.Block;
import things.Bush;
import things.CastleLeft;
import things.CastleRight;
import things.DesertSign;
import things.ForestSign;
import things.Inn;
import things.ItemShop;
import things.MountainSign;
import things.SlotMachine;
import things.WeaponShop;
import things.Well;
import openfl.display.BlendMode;

class PlayState extends FlxState
{
	public var stuff:FlxSpriteGroup;
	public var zones:FlxGroup;
	public var npcZones:FlxGroup;
	public var coins:FlxTypedGroup<Coin>;
	
	var blocks:FlxGroup;
	var surprise:FlxSprite;
	
	override public function create():Void
	{
		//FlxG.fullscreen = true;
		FlxG.mouse.visible = false;
		super.create();
		Reg.playState = this;
		
		coins = new FlxTypedGroup();
		
		add(new FlxSprite(0, 0, "assets/images/bg.png"));
		
		zones = new FlxGroup();
		add(zones);
		
		npcZones = new FlxGroup();
		add(npcZones);
		
		stuff = new FlxSpriteGroup();
		add(stuff);
		blocks = new FlxGroup();
		add(blocks);
		
		var bushArray:Array<Int> = [
			1,1,1,1,0,0,0,0,0,2,2,2,0,0,0,0,1,1,1,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,
			2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,
			2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,1,1,1,1,1,1,1,0,0,0,1,1,1,1,1,1,1,1,1,
			1,1,1,1,1,1,1,1,2,2,2,1,1,1,1,1,1,1,1,1
		];
		
		for (Y in 0...12) {
			for (X in 0...20) {
				if (bushArray[X + Y * 20] == 1) stuff.add(new Bush(X, Y));
				if (bushArray[X + Y * 20] == 2) blocks.add(new Block(X, Y));
			}
		}
		
		itemShop = new ItemShop();
		well = new Well();
		weaponShop = new WeaponShop();
		inn = new Inn();
		
		knight = new Knight();
		mage = new Mage();
		
		stuff.add(new Player());
		stuff.add(new CastleLeft());
		stuff.add(new CastleRight());
		stuff.add(well);
		stuff.add(itemShop);
		stuff.add(weaponShop);
		stuff.add(inn);
		stuff.add(knight);
		stuff.add(new King());
		stuff.add(new Granny());
		stuff.add(mage);
		stuff.add(new MountainSign());
		stuff.add(new ForestSign());
		stuff.add(new ForestSign());
		stuff.add(new DesertSign());
		stuff.add(new SlotMachine());
		
		surprise = new FlxSprite(0, 0, "assets/images/actionMark.png");
		surprise.scale.y = 0;
		add(surprise);
		
		black = new FlxSprite();
		black.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		black.blend = BlendMode.DARKEN;
		black.alpha = 1;
		add(black);
		
		var opening = new DialogBox(Reg.ACTOR_MOM, "Wake up sleepyhead!+nThe King wants to speak+nto you about something!");
		opening.closeCallback = wakeUpNoTimer;
		openSubState(opening);
	}
	
	var black:FlxSprite;
	public var itemShop:ItemShop;
	var well:Well;
	public var weaponShop:WeaponShop;
	var inn:Inn;
	var knight:Knight;
	var mage:Mage;
	
	override public function update(elapsed:Float):Void 
	{
		surprised = false;
		surprise.setPosition(Reg.player.x, Reg.player.y - 32);
		Reg.gold = Math.floor(ZMath.clamp(Reg.gold, 0, 999999));
		if (FlxG.keys.justPressed.I) openSubState(new Inventory());
		if (FlxG.keys.justPressed.O) openSubState(new Trash());
		if (FlxG.keys.justPressed.Y) openSubState(new Shop(itemShop));
		FlxG.overlap(Reg.player, coins, getCoin);
		FlxG.collide(stuff, stuff);
		FlxG.collide(Reg.player, blocks);
		if (!Reg.asleep) {
			FlxG.overlap(Reg.player, zones, zoneOverlap);
			FlxG.overlap(Reg.player, npcZones, npcZoneOverlap);
		}
		stuff.sort(FlxSort.byY, FlxSort.ASCENDING);
		if (surprise.scale.y == 0 && surprised) FlxTween.tween(surprise.scale, { y:1 }, 0.2, { ease:FlxEase.backOut } );
		else if (!surprised && surprise.scale.y == 1) FlxTween.tween(surprise.scale, { y:0 }, 0.1, { ease:FlxEase.backIn } );
		super.update(elapsed);
	}
	
	function getCoin(p:Player, c:Coin):Void
	{
		c.getCoin();
	}
	
	var surprised:Bool = false;
	
	function zoneOverlap(p:Player, z:Zone):Void
	{
		surprised = true;
		if (FlxG.keys.anyJustPressed([FlxKey.SPACE, FlxKey.Z])) z.parent.action();
	}
	
	function npcZoneOverlap(p:Player, z:NPCZone):Void
	{
		surprised = true;
		if (FlxG.keys.anyJustPressed([FlxKey.SPACE, FlxKey.Z])) z.parent.action();
	}
	
	public function sleepyTime():Void
	{
		FlxTween.tween(black, { alpha:1 }, 1);
		Reg.asleep = true;
	}
	
	public function wakeUp(?t:FlxTimer):Void
	{
		FlxTween.tween(black, { alpha:0 }, 1);
		Reg.asleep = false;
		setWaitTimersToZero();
	}
	
	public function wakeUpNoTimer():Void
	{
		FlxTween.tween(black, { alpha:0 }, 1);
		Reg.asleep = false;
	}
	
	public function setWaitTimersToZero():Void
	{
		knight.waitTimer = 0;
		mage.waitTimer = 0;
	}
	
}