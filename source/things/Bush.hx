package things;

/**
 * ...
 * @author x01010111
 */
class Bush extends Thing
{

	public function new(X:Int, Y:Int) 
	{
		super("assets/images/bush.png", X, Y, 1);
		actionable = false;
	}
	
}