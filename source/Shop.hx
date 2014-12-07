package ;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup;
import flixel.input.keyboard.FlxKey;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.FlxG;

/**
 * ...
 * @author x01010111
 */
class Shop extends FlxSubState
{
	var bg:FlxSprite;
	var box:FlxSprite;
	var items:FlxSpriteGroup;
	var gold:FlxText;
	var goldHelper:Int;
	var inv:Array<Item>;
	
	public function new(parent:Thing) 
	{
		super();
		
		goldHelper = Reg.gold;
		inv = parent.pocket.items;
		
		bg = new FlxSprite(0, 0);
		bg.makeGraphic(FlxG.width, FlxG.height, 0xff000000);
		bg.alpha = 0;
		add(bg);
		FlxTween.tween(bg, { alpha:0.5 }, 0.5);
		
		box = new FlxSprite(48, FlxG.height, "assets/images/shopBox.png");
		add(box);
		FlxTween.tween(box, { y:16 }, 0.2, { ease:FlxEase.backOut } ).onComplete = function(t:FlxTween):Void { goldCounter = true; }
		
		items = new FlxSpriteGroup();
		add(items);
		
		for (i in 0...inv.length) {
			var item:Item = new Item(inv[i].animation.frameIndex, inv[i].name, inv[i].cost);
			item.setPosition(64, 32 + i * 16);
			item.scale.set();
			items.add(item);
			
			var desc:FlxText = new FlxText(item.x + 18, item.y + 2, 200, item.name);
			desc.setFormat(null, 8, 0xd27d2c, FlxTextAlign.LEFT, FlxTextBorderStyle.SHADOW, 0x140c1c);
			desc.scale.set();
			items.add(desc);
			
			var cost:FlxText = new FlxText(item.x, item.y + 2, 126, "G:" + item.cost);
			cost.setFormat(null, 8, 0xd27d2c, FlxTextAlign.RIGHT, FlxTextBorderStyle.SHADOW, 0x140c1c);
			cost.scale.set();
			items.add(cost);
			
			new FlxTimer().start(0.1 + i * 0.1).onComplete = function(t:FlxTimer):Void { FlxTween.tween(item.scale, { x:1, y:1 }, 0.5, { ease:FlxEase.elasticOut } ); FlxTween.tween(desc.scale, { x:1, y:1 }, 0.3, { ease:FlxEase.backOut } ); FlxTween.tween(cost.scale, { x:1, y:1 }, 0.3, { ease:FlxEase.backOut } ); }
		}
		
		indicator = new FlxSprite(45, 0, "assets/images/selector.png");
		indicator.scale.set();
		FlxTween.tween(indicator.scale, { x:1, y:1 }, 0.4, { ease:FlxEase.backOut } );
		add(indicator);
		
		gold = new FlxText(212, 136, 48);
		gold.setFormat(null, 8, 0xd27d2c, FlxTextAlign.RIGHT, FlxTextBorderStyle.SHADOW, 0x140c1c);
		add(gold);
	}
	
	var indicator:FlxSprite;
	var goldCounter:Bool = false;
	var currentItem:Int = 0;
	
	override public function update(elapsed:Float):Void 
	{
		if (goldHelper - 1000 > Reg.gold) goldHelper -= 999;
		else if (goldHelper - 100 > Reg.gold) goldHelper -= 99;
		else if (goldHelper - 10 > Reg.gold) goldHelper -= 9;
		else if (goldHelper > Reg.gold) goldHelper--;
		if (goldCounter) gold.text = "" + goldHelper;
		super.update(elapsed);
		if (FlxG.keys.anyJustPressed([FlxKey.UP, FlxKey.W])) currentItem == 0? currentItem = inv.length - 1: currentItem--;
		else if (FlxG.keys.anyJustPressed([FlxKey.DOWN, FlxKey.S])) currentItem == inv.length - 1? currentItem = 0: currentItem++;
		else if (FlxG.keys.anyJustPressed([FlxKey.Q, FlxKey.X])) close();
		else if (FlxG.keys.anyJustPressed([FlxKey.SPACE, FlxKey.Z])) buyCurrentItem();
		indicator.velocity.y = ((34 + currentItem * 16) - indicator.y) * 8;
		indicator.angle = indicator.velocity.y * 0.25;
	}
	
	function buyCurrentItem():Void
	{
		if (Reg.gold < inv[currentItem].cost) {
			FlxG.state.openSubState(new DialogBox(2, "Sorry kid, you don't have+nenough gold!"));
		} else if (Reg.player.pocket.items.length >= 7 * 8) {
			FlxG.state.openSubState(new DialogBox(2, "Sorry kid, you're already+ncarrying too much stuff!"));
		} else {
			indicator.scale.set(1.3, 1.25);
			FlxTween.tween(indicator.scale, { x:1, y:1 }, 0.2, { ease:FlxEase.backInOut } );
			Reg.gold -= inv[currentItem].cost;
			Reg.player.pocket.addItemToPocket(new Item(inv[currentItem].animation.frameIndex, inv[currentItem].name, inv[currentItem].cost));
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