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
	public static var actors:Array<String> = ["Mom", "King", "Shop Keeper"];
	public static var playState:PlayState;
	public static var player:Player;
	public static var gold:Int = 5995;
	public static var luck:Float = 0;
}