package ;
import flixel.FlxSprite;

/**
 * ...
 * @author x01010111
 */
class Thing extends FlxSprite
{
	public var actionable:Bool = true;
	public var pocket:Pocket;
	
	public function new(G:String, X:Int, Y:Int, H:Int) 
	{
		super(X * 16, Y * 16, G);
		offset.set(0, height - H * 16);
		height = H * 16;
		immovable = true;
		pocket = new Pocket();
	}
	
	public function action():Void
	{
		
	}
	
}