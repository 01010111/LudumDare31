package people;

/**
 * ...
 * @author x01010111
 */
class Granny extends NPC
{

	public function new() 
	{
		super(280, 24);
		loadGraphic("assets/images/granny.png", true, 25, 32);
		makeBox();
		elasticity = 0;
	}
	
	var animTrigger:Bool = false;
	
	override public function update(elapsed:Float):Void 
	{
		if (animTrigger) {
			if (animation.frameIndex == 0) {
				if (Math.random() > 0.95) animation.frameIndex = 2;
				else if (Math.random() > 0.9) animation.frameIndex = 1;
			} else if (animation.frameIndex == 2) {
				if (Math.random() > 0.3) animation.frameIndex = 0;
			} else {
				if (Math.random() > 0.92) animation.frameIndex = 0;
			}
			animTrigger = false;
		} else animTrigger = true;
		super.update(elapsed);
		immovable = true;
	}
	
	override public function action():Void 
	{
		var a = Reg.ACTOR_GRANNY;
		var s = Reg.STORY_GRANNY;
		
		switch(Reg.story[s]) {
			case 0:
				talk(a, "Well hello there, +nyou big dummy.");
			case 1:
				talk(a, "Old fuddlebutt wants some +npie, huh? Well I need some +nMulberries! Go fetch some!");
				Reg.story[s] = 2;
				Reg.story[Reg.STORY_KING] = 1;
			case 2:
				if (Reg.player.pocket.checkForItem(Items.MULBERRY)) {
					Reg.story[s] = 3;
					Reg.player.pocket.removeItemFromPocket(Items.MULBERRY);
					talk(a, "Hey you got some!+nWait...I can't remember +nwhere I put my Frying Pan...");
				} else talk(a, "Mulberries can be found+nto the West in the+nmountains!");
		}
	}
	
}