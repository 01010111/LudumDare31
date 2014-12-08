package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;

/**
 * ...
 * @author x01010111
 */
class NPC extends FlxSprite
{
	public var target:FlxPoint;
	public var waitTimer:Int = 0;
	var tempTarget:FlxPoint;

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//immovable = true;
		elasticity = 0.8;
		maxVelocity.set(50, 50);
		drag.set(50, 50);
		target = tempTarget = FlxPoint.get(x, y);
	}
	
	function makeBox():Void
	{
		var w = width;
		var h = height;
		setSize(16, 12);
		offset.set((w - width) * 0.5, (h - height));
		var zone = new NPCZone(this);
	}
	
	var targetCounter:Int = 300;
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		var m = getMidpoint();
		if (target != null) {
			var a:FlxPoint = ZMath.velocityFromAngle(ZMath.angleBetween(m.x, m.y, target.x, target.y), 800);
			acceleration = a;
			if (Math.abs(target.x - x) < 8 && Math.abs(target.y - y) < 8) {
				acceleration = FlxPoint.get();
				velocity.set(velocity.x * 0.5, velocity.y * 0.5);
				immovable = false;
				targetCounter = 300;
				//target = null;
			} else {
				if (targetCounter <= 0) immovable = true;
				else targetCounter--;
			}
			
			if (waitTimer > 0) waitTimer--;
			else if (waitTimer == 0) {
				target.set(tempTarget.x, tempTarget.y);
				waitTimer = -1;
			}
		}
	}
	
	public function action():Void
	{
		
	}
	
	function setCoinAmt(N:Int, V:Int):Void
	{
		numCoins = N;
		coinVal = V;
	}
	
	var numCoins:Int = 10;
	var coinVal:Int = 10;
	
	function spewCoins():Void
	{
		for (i in 0...numCoins) new FlxTimer().start(0.01 + i * 0.1).onComplete = function(t:FlxTimer):Void { var c:Coin = new Coin(x + width * 0.5, y + height - 8, ZMath.velocityFromAngle(ZMath.angleBetween(x, y, FlxG.width * 0.5, FlxG.height * 0.5) + Math.random() * 45 - 22, ZMath.randomRange(80, 200)), coinVal); }
	}
	
	function giveCoins(?NumCoins:Int = 10, ?CoinVal:Int = 10):Void
	{
		setCoinAmt(NumCoins, CoinVal);
		spewCoins();
	}
	
	public function talk(A:Int, T:String):Void
	{
		Reg.playState.openSubState(new DialogBox(A, T));
	}
	
	function getRandomTalk(A:Array<String>):String
	{
		return A[ZMath.randomRangeInt(0, A.length - 1)];
	}
	
}