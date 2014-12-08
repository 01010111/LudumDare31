package people;
import flixel.FlxG;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import items.Mulberry;

/**
 * ...
 * @author x01010111
 */
class Knight extends NPC
{

	public function new() 
	{
		super(176, 80);
		loadGraphic("assets/images/knight.png", true, 36, 44);
		makeBox();
		animation.add("idle", [0]);
		animation.add("walk", [0, 1, 0, 2], 12);
		target = FlxPoint.get(x, y);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		if (velocity.x == 0 && velocity.y == 0) animation.play("idle");
		else animation.play("walk");
	}
	
	var drunkTalk:Array<String> = ["+sHICCUP+s","I +sused+s to be a+nreal adventurer if +nyou could believe it!","If I had my trusty sword+nI would adventure out+ninto the mountains!"];
	
	override public function action():Void 
	{
		var a = Reg.ACTOR_KNIGHT;
		var s = Reg.STORY_KNIGHT;
		
		switch(Reg.story[s]) {
			case 0:
				if (Reg.player.pocket.checkForItem(Items.RUSTY_SWORD)) {
					Reg.player.pocket.removeItemFromPocket(Items.RUSTY_SWORD);
					talk(a, "Well if it ain't my+nold trusty sword! Thanks+nkid! Now watch me go!");
					target.set( -64, 96);
					tempTarget.set(32, 80);
					waitTimer = 1200;
					Reg.story[s] = 1;
				} else talk(a, getRandomTalk(drunkTalk));
			case 1:
				if (waitTimer <= 0) {
					var t = new DialogBox(a, "Here's your share of the +nloot! I also found some+nMulberries! Help yourself!");
					Reg.story[s] = 2;
					setCoinAmt(10, 10);
					t.closeCallback = spewCoins;
					Reg.playState.openSubState(t);
					Reg.player.pocket.addItemToPocket(new Mulberry());
				}
			case 2:
				talk(a, "Whew! What a rush!+nGimme 80 Gold and I'll go+nback out and split my loot!");
				Reg.story[s] = 3;
			case 3:
				if (Reg.gold >= 80) {
					talk(a, "Alright boss, here I +n+sGOOOOOO+s!");
					target.set( -64, 96);
					tempTarget.set(32, 80);
					waitTimer = 1200;
					Reg.story[s] = 1;
				}
		}
		
	}
	
	
	
}