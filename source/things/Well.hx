package things;
import flixel.FlxG;
import flixel.math.FlxPoint;

/**
 * ...
 * @author x01010111
 */
class Well extends Thing
{

	public function new() 
	{
		super("assets/images/well.png", 9, 6, 1);
		
		var zone:Zone = new Zone(this, -8, -8, width + 16, height + 16);
	}
	
	override public function action():Void 
	{
		Reg.playState.openSubState(new Trash());
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (FlxG.keys.justPressed.P) var coin:Coin = new Coin(x + Math.random() * width, y, FlxPoint.get(Math.random() * 100 - 50, -100));
		super.update(elapsed);
	}
	
}