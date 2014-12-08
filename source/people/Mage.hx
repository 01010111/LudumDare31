package people;

/**
 * ...
 * @author x01010111
 */
class Mage extends NPC
{

	public function new() 
	{
		super(128, 144);
		loadGraphic("assets/images/mage.png", true, 24, 32);
		makeBox();
		animation.add("idle", [0]);
		animation.add("walk", [0, 1, 0, 2], 14);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (velocity.x == 0 && velocity.y == 0) animation.play("idle");
		else animation.play("walk");
		super.update(elapsed);
	}
	
	override public function action():Void 
	{
		var a = Reg.ACTOR_MAGE;
		var s = Reg.STORY_MAGE;
		
		switch(Reg.story[s]) {
			case 0:
		}
		
	}
	
}