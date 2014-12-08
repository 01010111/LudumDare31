package things;

/**
 * ...
 * @author x01010111
 */
class MountainSign extends Thing
{

	public function new() 
	{
		super("assets/images/mountainSign.png", 1, 7, 1);
		setSize(16, 2);
		offset.set(0, 12);
		y += 8;
	}
	
}