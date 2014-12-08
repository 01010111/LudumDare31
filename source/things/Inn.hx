package things;
import flixel.util.FlxTimer;

/**
 * ...
 * @author x01010111
 */
class Inn extends Thing
{

	public function new() 
	{
		super("assets/images/inn.png", 14, 6, 3);
		var zone:Zone = new Zone(this, 40, height, 32, 16);
	}
	
	var dadAdvice:Array<String> = ["TEST"];
	var stay:Bool = false;
	
	override public function action():Void 
	{
		if (Reg.gold == 0) {
			Reg.gold++;
			Reg.playState.openSubState(new DialogBox(Reg.ACTOR_SHOPKEEP, "+sWhoa there dummy!+s+nI can't have my only child+nrunning around town poor!", "Dad"));
			stay = false;
		} else if (Reg.gold < 100) {
			Reg.playState.openSubState(new DialogBox(Reg.ACTOR_SHOPKEEP, dadAdvice[Math.floor(Math.random() * dadAdvice.length)], "Dad"));
			stay = false;
		} else {
			if (!stay) {
				stay = true;
				Reg.playState.openSubState(new DialogBox(Reg.ACTOR_SHOPKEEP, "Hey moneybags! Why don't +nyou pay 100 Gold +nto spend the night!", "Dad"));
			} else {
				stay = false;
				Reg.gold -= 100;
				Reg.playState.sleepyTime();
				new FlxTimer().start(4, Reg.playState.wakeUp);
			}
		}
		super.action();
	}
	
}