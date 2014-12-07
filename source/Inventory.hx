package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

/**
 * ...
 * @author x01010111
 */
class Inventory extends FlxSubState
{
	var bg:FlxSprite;
	var box:FlxSprite;
	var items:FlxSpriteGroup;
	var gold:FlxText;
	var goldHelper:Int = 0;
	
	public function new() 
	{
		super();
		
		var inv:Array<Item> = Reg.player.pocket.items;
		
		bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		bg.alpha = 0;
		add(bg);
		FlxTween.tween(bg, { alpha:0.5 }, 0.5);
		
		box = new FlxSprite(48, FlxG.height, "assets/images/inventoryBox.png");
		add(box);
		FlxTween.tween(box, { y:16 }, 0.2, { ease:FlxEase.backOut } ).onComplete = function(t:FlxTween):Void { goldCounter = true; }
		
		items = new FlxSpriteGroup();
		add(items);
		
		var Y:Int = 0;
		var X:Int = 0;
		for (i in 0...inv.length) {
			if (X == 8) {
				X = 0;
				Y++;
			}
			
			var item:Item = new Item(inv[i].animation.frameIndex, inv[i].name, inv[i].cost);
			item.setPosition(64 + X * 16, 32 + Y * 16);
			item.scale.set();
			items.add(item);
			new FlxTimer().start(0.1 + i * 0.01).onComplete = function(t:FlxTimer):Void { FlxTween.tween(item.scale, { x:1, y:1 }, 0.5, { ease:FlxEase.elasticOut } ); }
			if (i < 32 && i > 24) trace(0.1 + i * 0.01);
			
			X++;
		}
		
		gold = new FlxText(212, 136, 48);
		gold.setFormat(null, 8, 0xd27d2c, FlxTextAlign.RIGHT, FlxTextBorderStyle.SHADOW, 0x140c1c);
		add(gold);
	}
	
	var goldCounter:Bool = false;
	
	override public function update(elapsed:Float):Void 
	{
		if (goldHelper + 1000 < Reg.gold) goldHelper += 999;
		else if (goldHelper + 100 < Reg.gold) goldHelper += 99;
		else if (goldHelper + 10 < Reg.gold) goldHelper += 9;
		else if (goldHelper < Reg.gold) goldHelper++;
		if (goldCounter) gold.text = "" + goldHelper;
		super.update(elapsed);
		if (FlxG.keys.justPressed.ANY) close();
	}
	
	override public function close():Void 
	{
		for (i in 0...items.length) FlxTween.tween(items.members[i].scale, { x:0, y:0 }, 0.2, { ease:FlxEase.backIn } );
		FlxTween.tween(gold.scale, { x:0, y:0 }, 0.2, { ease:FlxEase.backIn } );
		FlxTween.tween(bg, { alpha:0 }, 0.3, { ease:FlxEase.backIn } );
		FlxTween.tween(box, { y:FlxG.height }, 0.3, { ease:FlxEase.backIn } );
		new FlxTimer().start(0.3, reallyClose);
	}
	
	function reallyClose(t:FlxTimer):Void
	{
		super.close();
	}
	
}