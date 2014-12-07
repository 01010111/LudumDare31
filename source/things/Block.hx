package things ;

/**
 * ...
 * @author x01010111
 */
class Block extends Thing
{

	public function new(X:Int, Y:Int) 
	{
		super("assets/images/block.png", X, Y, 1);
		#if debug
		alpha = 1;
		#else
		alpha = 0;
		#end
		actionable = false;
		
		var zone:Zone = new Zone(this, -8, -8, width + 16, height + 16);
	}
	
	var momNag:Array<String> = ["You can't go out dressed+nlike +sTHAT+s, dummy!", "Where are you going, dummy?+nYou haven't finished your+nhomework!!!", "What's the matter with you?+nYou still have chores to do!+n+sDUMMY!!!+s"];
	
	override public function action():Void 
	{
		Reg.playState.openSubState(new DialogBox(0, momNag[Math.floor(Math.random() * momNag.length)]));
	}
	
}