package ;
import flixel.FlxG;

/**
 * ...
 * @author x01010111
 */
class Pocket
{
	public var items:Array<Item>;
	
	public function new() 
	{
		items = new Array();
	}
	
	public function addItemToPocket(ITEM:Item):Bool
	{
		if (items.length < 7 * 8) {
			items.push(ITEM);
			return true;
		}
		else {
			FlxG.state.openSubState(new DialogBox(0, "+sYou Dummy!+s+nYour pockets are full!!!"));
			return false;
		}
	}
	
	public function removeItemFromPocket(ItemID:Int, HowMany:Int = 1):Void
	{
		var n = 0;
		for (i in 0...items.length) {
			if (items[i].animation.frameIndex == ItemID) {
				items.remove(items[i]);
				n++;
				if (n >= HowMany) break;
			}
		}
	}
	
	public function countItems(ItemId:Int):Int
	{
		var n:Int = 0;
		for (i in 0...items.length) {
			if (items[i].animation.frameIndex == ItemId) {
				n++;
			}
		}
		return n;
	}
	
	public function checkForItem(ItemID:Int):Bool
	{
		var b = false;
		for (i in 0...items.length) {
			if (items[i].animation.frameIndex == ItemID) {
				b = true;
				break;
			}
		}
		return b;
	}
	
}