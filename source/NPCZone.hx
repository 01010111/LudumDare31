package ;
import flixel.FlxSprite;

/**
 * ...
 * @author x01010111
 */
class NPCZone extends FlxSprite
{
	public var parent:NPC;
	var sizer:Int = 8;
	
	public function new(Parent:NPC) 
	{
		super(Parent.x - sizer, Parent.y - sizer);
		#if debug
		makeGraphic(Math.floor(Parent.width + sizer * 2), Math.floor(Parent.height + sizer * 2), 0x60FF0000);
		#else
		makeGraphic(Math.floor(Parent.width + sizer * 2), Math.floor(Parent.height + sizer * 2), 0x00000000);
		#end
		parent = Parent;
		Reg.playState.npcZones.add(this);
	}
	
	override public function update(elapsed:Float):Void 
	{
		setPosition(parent.x - sizer, parent.y - sizer);
		super.update(elapsed);
	}
	
}