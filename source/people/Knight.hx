package people;
import flixel.FlxG;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;

/**
 * ...
 * @author x01010111
 */
class Knight extends NPC
{

	public function new() 
	{
		super(176, 80);
		loadGraphic("assets/images/knight.png", true, 36, 44);
		makeBox();
		animation.add("idle", [0]);
		animation.add("walk", [0, 1, 0, 2], 12);
		elasticity = 0.8;
		maxVelocity.set(50, 50);
		drag.set(50, 50);
	}
	
	var target:FlxPoint;
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (velocity.x == 0 && velocity.y == 0) animation.play("idle");
		else animation.play("walk");
		var m = getMidpoint();
		if (target != null) {
			var a:FlxPoint = ZMath.velocityFromAngle(ZMath.angleBetween(m.x, m.y, target.x, target.y), 800);
			acceleration = a;
			if (Math.abs(target.x - x) < 8 && Math.abs(target.y - y) < 8) {
				acceleration = FlxPoint.get();
				velocity.set(velocity.x * 0.5, velocity.y * 0.5);
				target = null;
			}
		}
		if (FlxG.keys.justPressed.T) target = FlxPoint.get(Reg.player.x, Reg.player.y);
	}
	
}