package;

import flixel.util.FlxSave;
import items.GoldenHelm;
import items.Mulberry;
import items.RustySword;

/**
 * Handy, pre-built Registry class that can be used to store 
 * references to objects and other things for quick-access. Feel
 * free to simply ignore it or change it in any way you like.
 */
class Reg
{
	public static var ACTOR_MOM:Int = 0;
	public static var ACTOR_KING:Int = 1;
	public static var ACTOR_SHOPKEEP:Int = 2;
	public static var ACTOR_KNIGHT:Int = 3;
	public static var ACTOR_GRANNY:Int = 4;
	public static var ACTOR_MAGE:Int = 5;
	
	public static var actors:Array<String> = ["Mom", "King", "Shop Keeper", "Knight", "Granny", "Mage"];
	public static var playState:PlayState;
	public static var player:Player;
	public static var gold:Int = 15;
	public static var luck:Float = 0;
	public static var asleep:Bool = false;
	
	public static var STORY_KING:Int = 0;
	public static var STORY_GRANNY:Int = 1;
	public static var STORY_KNIGHT:Int = 2;
	public static var STORY_MAGE:Int = 3;
	public static var STORY_ITEMSHOP:Int = 4;
	public static var STORY_WEAPONSHOP:Int = 5;
	public static var story:Array<Int> = [0, 0, 0, 0, 0, 0];
}