package things;

/**
 * ...
 * @author x01010111
 */
class ForestSign extends Thing
{

	public function new() 
	{
		super("assets/images/forestSign.png", 18, 4, 1);
		setSize(16, 2);
		offset.set(0, 12);
		//y += 8;
	}
	
}