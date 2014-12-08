package things;

/**
 * ...
 * @author x01010111
 */
class DesertSign extends Thing
{

	public function new() 
	{
		super("assets/images/desertSign.png", 11, 9, 1);
		setSize(16, 2);
		offset.set(0, 12);
		y += 8;
	}
	
}