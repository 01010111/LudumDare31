package things;

/**
 * ...
 * @author x01010111
 */
class Well extends Thing
{

	public function new() 
	{
		super("assets/images/well.png", 9, 6, 1);
		
		var zone:Zone = new Zone(this, -12, -12, width + 24, height + 24);
	}
	
	override public function action():Void 
	{
		Reg.playState.openSubState(new Trash());
	}
	
}