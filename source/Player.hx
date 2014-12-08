package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.input.keyboard.FlxKey;
import items.RustySword;

/**
 * ...
 * @author x01010111
 */
class Player extends FlxSprite
{
	var speed:Int = 160;
	public var pocket:Pocket;
	
	public function new() 
	{
		Reg.player = this;
		super(256, 144);
		loadGraphic("assets/images/player.png", true, 20, 32);
		animation.add("idle", [0]);
		animation.add("running", [0, 1, 0, 2], 16);
		setSize(16, 12);
		offset.set(2, 20);
		maxVelocity.set(speed, speed);
		drag.set(1000, 1000);
		
		pocket = new Pocket();
		//pocket.addItemToPocket(new RustySword());
	}
	
	var accel:Int = 1500;
	
	override public function update(elapsed:Float):Void 
	{
		acceleration.set();
		if (!Reg.asleep) {
			if (FlxG.keys.anyPressed([FlxKey.W, FlxKey.UP])) acceleration.y -= accel;
			if (FlxG.keys.anyPressed([FlxKey.S, FlxKey.DOWN])) acceleration.y += accel;
			if (FlxG.keys.anyPressed([FlxKey.A, FlxKey.LEFT])) acceleration.x -= accel;
			if (FlxG.keys.anyPressed([FlxKey.D, FlxKey.RIGHT])) acceleration.x += accel;
			velocity.x == 0 && velocity.y == 0? animation.play("idle"): animation.play("running");
			super.update(elapsed);
		}
	}
	
	function warping():Void
	{
		if (x < 0 - 16) {
			y = 80;
			x = FlxG.width + 2;
		} else if (x > FlxG.width + 2) {
			y = 96;
			x = 0 - 16;
		} else if (y < 0 - 12) {
			y = FlxG.height + 12;
			x = 144;
		} else if (y > FlxG.height + 12) {
			y = 0 - 12;
			x = 160;
		}
	}
	
}