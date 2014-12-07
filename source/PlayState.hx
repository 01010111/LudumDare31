package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSort;
import items.GoldenHelm;
import items.Mulberry;
import items.RustySword;
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
	var stuff:FlxSpriteGroup;
	public var zones:FlxGroup;
	
	override public function create():Void
	{
		FlxG.mouse.visible = false;
		super.create();
		Reg.playState = this;
		
		add(new FlxSprite(0, 0, "assets/images/bg.png"));
		
		zones = new FlxGroup();
		add(zones);
		
		stuff = new FlxSpriteGroup();
		add(stuff);
		
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
				if (bushArray[X + Y * 20] == 2) stuff.add(new Block(X, Y));
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
	}
	
	var itemShop:ItemShop;
	var well:Well;
	var weaponShop:WeaponShop;
	var inn:Inn;
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.justPressed.T) openSubState(new DialogBox(0, "Testing text,+nI +sdunno+s if it will work."));
		if (FlxG.keys.justPressed.I) openSubState(new Inventory());
		if (FlxG.keys.justPressed.O) openSubState(new Trash());
		if (FlxG.keys.justPressed.Y) openSubState(new Shop(itemShop));
		FlxG.collide(stuff, stuff);
		FlxG.overlap(Reg.player, zones, zoneOverlap);
		stuff.sort(FlxSort.byY, FlxSort.ASCENDING);
		super.update(elapsed);
	}
	
	function zoneOverlap(p:Player, z:Zone):Void
	{
		if (FlxG.keys.anyJustPressed([FlxKey.SPACE, FlxKey.Z])) z.parent.action();
	}
	
}