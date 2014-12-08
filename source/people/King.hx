package people;
import flixel.FlxG;
import flixel.math.FlxPoint;
import openfl._internal.renderer.opengl.shaders.AbstractShader;

/**
 * ...
 * @author x01010111
 */
class King extends NPC
{
	
	public function new() 
	{
		super(160, 32);
		loadGraphic("assets/images/king.png", true, 34, 41);
		makeBox();
		animation.add("idle", [0]);
		animation.add("walk", [0, 1, 2, 1], 12);
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		animation.play("walk");
	}
	
	var wantPie:Array<String> = ["Boy I tell ya!+nI would love some+nMulberry Pie!!!", "Old Gran over there used+nto make some great Mulberry +nPie back in the day!", "+sPlease!+s+nGet me some+nMulberry Pie!!!"];
	
	override public function action():Void 
	{
		var a = Reg.ACTOR_KING;
		var s = Reg.STORY_KING;
		
		switch(Reg.story[s]) {
			case 0: //WANT PIE
				Reg.story[Reg.STORY_GRANNY] = 1;
				talk(a, getRandomTalk(wantPie));
			case 1: //FUDDLES
				target.set(160, -64);
				talk(a, "Well +sFUDDLES+s. I want my pie! +nCome get me when it's ready+nto eat!");
			case 2: //GO TO CASTLE
				
			case 3: //SELL CASTLE
				
		}
		
	}
	
}