package ;
import flixel.FlxSprite;

/**
 * ...
 * @author x01010111
 */
class Zone extends FlxSprite
{
	public var parent:Thing;
	
	public function new(Parent:Thing, X:Float, Y:Float, W:Float, H:Float) 
	{
		super(Parent.x + X, Parent.y + Y);
		#if debug
		makeGraphic(Math.floor(W), Math.floor(H), 0x60FF0000);
		#else
		makeGraphic(Math.floor(W), Math.floor(H), 0x00000000);
		#end
		parent = Parent;
		Reg.playState.zones.add(this);
	}
	
}