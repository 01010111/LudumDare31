package ;
import flixel.FlxSprite;

/**
 * ...
 * @author x01010111
 */
class Item extends FlxSprite
{
	public var name:String;
	public var cost:Int;
	
	public function new(FRAME:Int, NAME:String, COST:Int) 
	{
		super();
		loadGraphic("assets/images/icons.png", true, 16, 16);
		animation.frameIndex = FRAME;
		name = NAME;
		cost = COST;
	}
	
}