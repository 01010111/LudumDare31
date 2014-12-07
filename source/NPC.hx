package ;
import flixel.FlxSprite;

/**
 * ...
 * @author x01010111
 */
class NPC extends FlxSprite
{

	public function new(X:Float, Y:Float) 
	{
		super(X, Y);
		//immovable = true;
	}
	
	function makeBox():Void
	{
		var w = width;
		var h = height;
		setSize(16, 12);
		offset.set((w - width) * 0.5, (h - height));
	}
	
}