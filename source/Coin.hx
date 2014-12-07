package ;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;
import openfl.display.BlendMode;

/**
 * ...
 * @author x01010111
 */
class Coin extends FlxSprite
{
	var counter:Int = 300;
	
	public function new(X:Float, Y:Float, V:FlxPoint) 
	{
		super(X, Y);
		loadGraphic("assets/images/coin.png", true, 8, 10);
		animation.add("play", [0, 1, 2, 3], 20);
		animation.play("play");
		velocity.set(V.x + Math.random() * 50 - 25, V.y + Math.random() * 50 - 25);
		elasticity = 0.8;
		drag.set(300, 300);
		Reg.playState.stuff.add(this);
		Reg.playState.coins.add(this);
	}
	
	var dis:Int;
	
	override public function update(elapsed:Float):Void 
	{
		if (counter == 100) FlxSpriteUtil.flicker(this, 0);
		if (counter <= 0) kill();
		var c:FlxPoint = getMidpoint();
		var p:FlxPoint = Reg.player.getMidpoint();
		var d:Float = ZMath.distance(c.x, c.y, p.x, p.y);
		var a:FlxPoint = ZMath.velocityFromAngle(ZMath.angleBetween(c.x, c.y, p.x + 12, p.y), 100);
		if (d < dis * 0.5) acceleration.set(a.x, a.y);
		super.update(elapsed);
		dis++;
	}
	
	public function getCoin():Void
	{
		if (alive) {
			Reg.gold++;
			allowCollisions = FlxObject.NONE;
			velocity.set();
			acceleration.set();
			if (Reg.luck >= Math.random() * 10) Reg.gold++;
			if (Reg.luck >= Math.random() * 25) Reg.gold++;
			if (Reg.luck >= Math.random() * 50) Reg.gold++;
			kill();
		}
	}
	
	override public function kill():Void 
	{
		alive = false;
		blend = BlendMode.ADD;
		FlxTween.tween(scale, { x:0, y:3 }, 0.3, { ease:FlxEase.backIn } );
		new FlxTimer().start(0.32, superKill);
	}
	
	function superKill(t:FlxTimer):Void
	{
		super.kill();
	}
	
}