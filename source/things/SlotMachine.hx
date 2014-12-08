package things;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

/**
 * ...
 * @author x01010111
 */
class SlotMachine extends Thing
{
	var state:Int = 0;
	var slot1:FlxSprite;
	var slot2:FlxSprite;
	var slot3:FlxSprite;
	
	public function new() 
	{
		super("assets/images/slotMachine.png", 198, 16, 2);
		setPosition(198, 16);
		setSize(32, 32);
		offset.set(3, 0);
		immovable = true;
		
		slot1 = new FlxSprite(x + 2, y + 11);
		slot1.loadGraphic("assets/images/lucky.png", true, 7, 5);
		s1 = Math.floor(Math.random() * 3);
		slot1.immovable = true;
		Reg.playState.stuff.add(slot1);
		
		slot2 = new FlxSprite(x + 10, y + 11);
		slot2.loadGraphic("assets/images/lucky.png", true, 7, 5);
		s2 = Math.floor(Math.random() * 3);
		slot2.immovable = true;
		Reg.playState.stuff.add(slot2);
		
		slot3 = new FlxSprite(x + 18, y + 11);
		slot3.loadGraphic("assets/images/lucky.png", true, 7, 5);
		s3 = Math.floor(Math.random() * 3);
		slot3.immovable = true;
		Reg.playState.stuff.add(slot3);
		
		zone = new Zone(this, 8, height, 16, 12);
		Reg.playState.zones.add(zone);
	}
	
	var zone:Zone;
	var s1:Int;
	var s2:Int;
	var s3:Int;
	
	override public function update(elapsed:Float):Void 
	{
		s1 = s1 % 3;
		s2 = s2 % 3;
		s3 = s3 % 3;
		slot1.animation.frameIndex = s1;
		slot2.animation.frameIndex = s2;
		slot3.animation.frameIndex = s3;
		super.update(elapsed);
	}
	
	override public function action():Void 
	{
		if (state == 0) {
			spin();
		}
	}
	
	function spin():Void
	{
		scale.set(1.1, 1.2);
		FlxTween.tween(scale, { x:1, y:1 }, 0.5, { ease:FlxEase.elasticOut } );
		if (Reg.gold > 0) {
			state = 1;
			FlxTween.tween(this, { s1:Math.random() * 3 + 35 }, 1, { ease:FlxEase.sineOut } );
			FlxTween.tween(this, { s2:Math.random() * 3 + 35 }, 1.2, { ease:FlxEase.sineOut } );
			FlxTween.tween(this, { s3:Math.random() * 3 + 35 }, 2, { ease:FlxEase.sineOut } );
			new FlxTimer().start(2.2, checkWin);
			Reg.gold--;
			zone.y = y;
		} else Reg.playState.openSubState(new DialogBox(Reg.ACTOR_MOM, "You +sdummy+s!+nDon't gamble when you have+nno money to spend!"));
	}
	
	function checkWin(t:FlxTimer):Void
	{
		zone.y = y + height;
		state = 0;
		if (s1 == s2 && s2 == s3) {
			switch(s1) {
				case 0:
					for (i in 0...10) new FlxTimer().start(i * 0.1 + 0.01).onComplete = function(t:FlxTimer):Void { var c:Coin = new Coin(this.x + 2, this.height + 8, FlxPoint.get(Math.random() * 200 - 100, Math.random() * 120 + 100), 5); }
				case 1:
					for (i in 0...10) new FlxTimer().start(i * 0.1 + 0.01).onComplete = function(t:FlxTimer):Void { var c:Coin = new Coin(this.x + 2, this.height + 8, FlxPoint.get(Math.random() * 200 - 100, Math.random() * 120 + 100), 25); }
				case 2:
					for (i in 0...10) new FlxTimer().start(i * 0.1 + 0.01).onComplete = function(t:FlxTimer):Void { var c:Coin = new Coin(this.x + 2, this.height + 8, FlxPoint.get(Math.random() * 200 - 100, Math.random() * 120 + 100), 50); }
			}
		}
	}
	
}