package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

/**
 * ...
 * @author x01010111
 */
class Trash extends FlxSubState
{
	var bg:FlxSprite;
	var box:FlxSprite;
	var items:FlxSpriteGroup;
	var gold:FlxText;
	var goldHelper:Int = 0;
	var inv:Array<Item>;
	var iLayer:FlxGroup;
	
	public function new() 
	{
		super();
		bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		bg.alpha = 0;
		add(bg);
		FlxTween.tween(bg, { alpha:0.5 }, 0.5);
		
		box = new FlxSprite(48, FlxG.height, "assets/images/trashBox.png");
		add(box);
		FlxTween.tween(box, { y:16 }, 0.2, { ease:FlxEase.backOut } ).onComplete = function(t:FlxTween):Void { goldCounter = true; }
		
		iLayer = new FlxGroup();
		add(iLayer);
		addItems();
		
		gold = new FlxText(212, 136, 48);
		gold.setFormat(null, 8, 0xd27d2c, FlxTextAlign.RIGHT, FlxTextBorderStyle.SHADOW, 0x140c1c);
		add(gold);
		
		indicator = new FlxSprite();
		indicator.loadGraphic("assets/images/selector.png");
		add(indicator);
	}
	
	function addItems(w:Float = 0.1):Void
	{
		items = new FlxSpriteGroup();
		iLayer.add(items);
		
		inv = Reg.player.pocket.items;
		
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
			new FlxTimer().start(w + i * 0.01).onComplete = function(t:FlxTimer):Void { FlxTween.tween(item.scale, { x:1, y:1 }, 0.5, { ease:FlxEase.elasticOut } ); }
			if (i < 32 && i > 24) trace(0.1 + i * 0.01);
			
			X++;
		}
	}
	
	var goldCounter:Bool = false;
	var indicator:FlxSprite;
	var currentItem:Int = 0;
	
	override public function update(elapsed:Float):Void 
	{
		Reg.gold = Math.floor(ZMath.clamp(Reg.gold, 0, 999999));
		if (goldHelper > Reg.gold) goldHelper = Reg.gold;
		if (goldHelper + 10000 < Reg.gold) goldHelper += 9999;
		else if (goldHelper + 1000 < Reg.gold) goldHelper += 999;
		else if (goldHelper + 100 < Reg.gold) goldHelper += 99;
		else if (goldHelper + 10 < Reg.gold) goldHelper += 9;
		else if (goldHelper < Reg.gold) goldHelper++;
		if (goldCounter) gold.text = "" + goldHelper;
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([FlxKey.Q, FlxKey.X])) close();
		if (FlxG.keys.anyJustPressed([FlxKey.Z, FlxKey.SPACE])) trashItem();
		
		if (FlxG.keys.anyJustPressed([FlxKey.UP, FlxKey.W])) {
			if (currentItem - 8 >= 0) currentItem -= 8;
		} else if (FlxG.keys.anyJustPressed([FlxKey.DOWN, FlxKey.S])) {
			if (currentItem + 8 < Reg.player.pocket.items.length) currentItem += 8;
		} else if (FlxG.keys.anyJustPressed([FlxKey.LEFT, FlxKey.A])) {
			if (currentItem % 8 != 0 && currentItem > 0) currentItem--;
		} else if (FlxG.keys.anyJustPressed([FlxKey.RIGHT, FlxKey.D])) {
			if (currentItem < Reg.player.pocket.items.length - 1 && (currentItem + 1) % 8 != 0) currentItem++;
		}
		
		indicator.x += ((48 + currentItem % 8 * 16) - indicator.x) * 0.1;
		indicator.y += ((34 + Math.floor(currentItem / 8) * 16) - indicator.y) * 0.1;
	} 
	
	function trashItem():Void
	{
		if (inv.length > 0 && currentItem < inv.length) {
			Reg.gold = Math.floor(ZMath.clamp(Reg.gold, 0, 999999));
			Reg.luck += inv[currentItem].cost * 0.01;
			Reg.gold += Math.floor(ZMath.clamp(inv[currentItem].cost * Reg.luck * 0.01, 0, 100));
			Reg.player.pocket.removeItemFromPocket(inv[currentItem].animation.frameIndex);
			items.kill();
			addItems(0.001);
		}
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