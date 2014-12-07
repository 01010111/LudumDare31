package things;
import items.CrystalSword;
import items.GildedSword;
import items.GoldenHelm;
import items.IronHelm;
import items.IronSword;
import items.RustySword;
import items.SteelHelm;

/**
 * ...
 * @author x01010111
 */
class WeaponShop extends Thing
{
	
	public function new() 
	{
		super("assets/images/weaponShop.png", 4, 2, 2);
		pocket.addItemToPocket(new RustySword());
		pocket.addItemToPocket(new IronSword());
		pocket.addItemToPocket(new GildedSword());
		pocket.addItemToPocket(new CrystalSword());
		pocket.addItemToPocket(new IronHelm());
		pocket.addItemToPocket(new SteelHelm());
		pocket.addItemToPocket(new GoldenHelm());
		
		var zone:Zone = new Zone(this, 8, height, width - 16, 16);
	}
	
	override public function action():Void 
	{
		Reg.playState.openSubState(new Shop(this));
	}
	
}