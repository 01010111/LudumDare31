package things ;
import items.BluePotion;
import items.Bolas;
import items.Bomb;
import items.FryingPan;
import items.GreenPotion;
import items.Milk;
import items.RedPotion;

/**
 * ...
 * @author x01010111
 */
class ItemShop extends Thing
{

	public function new() 
	{
		super("assets/images/itemShop.png", 1, 1, 2);
		pocket.addItemToPocket(new FryingPan());
		pocket.addItemToPocket(new BluePotion());
		pocket.addItemToPocket(new GreenPotion());
		pocket.addItemToPocket(new RedPotion());
		pocket.addItemToPocket(new Bolas());
		pocket.addItemToPocket(new Bomb());
		pocket.addItemToPocket(new Milk());
		var zone:Zone = new Zone(this, 8, height, Math.round(width - 16), 16);
	}
	
	override public function action():Void 
	{
		Reg.playState.openSubState(new Shop(this));
	}
	
}