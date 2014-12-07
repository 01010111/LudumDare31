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
import items.GoldenHelm;
import items.Mulberry;
import items.RustySword;
import people.Knight;
import things.Block;
import things.Bush;
import things.CastleLeft;
import things.CastleRight;
import things.Inn;
import things.ItemShop;
import things.WeaponShop;
import things.Well;

class PlayState extends FlxState
{
	public var stuff:FlxSpriteGroup;
	public var zones:FlxGroup;
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
		
		stuff.add(new Player());
		stuff.add(new CastleLeft());
		stuff.add(new CastleRight());
		stuff.add(well);
		stuff.add(itemShop);
		stuff.add(weaponShop);
		stuff.add(inn);
		stuff.add(new Knight());
		
		surprise = new FlxSprite(0, 0, "assets/images/actionMark.png");
		surprise.scale.y = 0;
		add(surprise);
	}
	
	var itemShop:ItemShop;
	var well:Well;
	var weaponShop:WeaponShop;
	var inn:Inn;
	
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
		FlxG.overlap(Reg.player, zones, zoneOverlap);
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
	
}