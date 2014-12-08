package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxPointer;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxTimer;

/**
 * ...
 * @author x01010111
 */
class DialogBox extends FlxSubState
{
	var back:FlxSprite;
	var actor:FlxSprite;
	var text:FlxSpriteGroup;
	var shakeText:FlxSpriteGroup;
	var shake:Bool = false;
	var timer:Int = 30;
	public var name:String;
	
	var alphabet:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.,?!':@#$%^&*() ";
	
	public function new(A:Int, T:String, ?Name:String) 
	{
		super();
		
		shakeText = new FlxSpriteGroup();
		
		back = new FlxSprite(8, FlxG.height - 72 + 64);
		//back.makeGraphic(FlxG.width - 16, 64, 0xFF442434);
		back.makeGraphic(FlxG.width - 16 + 4, 64 + 4, 0x00FFFFFF);
		var line:LineStyle = { color: 0xFF000000, thickness: 1 };
		FlxSpriteUtil.drawRect(back, 4, 4, FlxG.width - 16, 64, 0x80000000);
		FlxSpriteUtil.drawRect(back, 0, 0, FlxG.width - 16, 64, 0xFF442434, line);
		FlxSpriteUtil.drawRect(back, 4, 4, FlxG.width - 24, 57, 0x80000000);
		FlxSpriteUtil.drawRect(back, 4, 4, FlxG.width - 24, 4, 0x80000000);
		FlxSpriteUtil.drawRect(back, 4, 8, 4, 53, 0x80000000);
		back.scale.set(1, 0);
		add(back);
		FlxTween.tween(back, { y:FlxG.height - 72 }, 0.2, { ease:FlxEase.backOut } );
		FlxTween.tween(back.scale, { y:1 }, 0.2, { ease:FlxEase.backOut } );
		
		actor = new FlxSprite(20 - 60, 120);
		actor.loadGraphic("assets/images/actors.png", true, 40, 40);
		actor.animation.frameIndex = A;
		actor.angle = -45;
		add(actor);
		FlxTween.tween(actor, { x:20, angle:0 }, 0.3, { ease:FlxEase.backOut } );
		
		text = new FlxSpriteGroup();
		add(text);
		
		Name == null? name = Reg.actors[A]: name = Name;
		
		var i = 0;
		while (i < name.length) {
			addCharacter(name.charAt(i), FlxPoint.get(72, 116), i, 0, i);
			i++;
		}
		
		addCharacter(":", FlxPoint.get(72, 116), i, 0, i);
		
		i = 0;
		var X = 0;
		var Y = 0;
		while (i < T.length) {
			if (T.charAt(i) == "+") {
				if (T.charAt(i + 1) == "n") { X = 0; Y++; }
				if (T.charAt(i + 1) == "s") shake == true? shake = false: shake = true;
				i++;
			} else {
				addCharacter(T.charAt(i), FlxPoint.get(80, 130), X, Y, i);
				X++;
			}
			i++;
		}
		
		shakeTimer = new FlxTimer().start(0.02, shakeIt, 0);
	}
	
	var shakeTimer:FlxTimer;
	
	function shakeIt(t:FlxTimer):Void
	{
		for (i in 0...shakeText.length) if (shakeText.members[i] != null) shakeText.members[i].offset.set(Math.random() * 2 - 1, Math.random() * 2 - 1);
	}
	
	function addCharacter(C:String, P:FlxPoint, X:Int, Y:Int, I:Int):Void
	{
		var c:FlxSprite = new FlxSprite(P.x + X * 8, P.y + Y * 10);
		c.loadGraphic("assets/images/font1.png", true, 8, 9);
		for (i in 0...alphabet.length) {
			if (C == alphabet.charAt(i)) {
				c.animation.frameIndex = i;
				break;
			}
		}
		c.scale.set();
		new FlxTimer().start(I * 0.005 + 0.1).onComplete = function(t:FlxTimer):Void { FlxTween.tween(c.scale, { x:1, y:1 }, 0.1, { ease:FlxEase.backOut } ); }
		text.add(c);
		if (shake) shakeText.add(c);
	}
	
	override public function update(elapsed:Float):Void 
	{
		if (timer <= 0 && FlxG.keys.justPressed.ANY) {
			shakeTimer.cancel();
			shakeTimer.destroy();
			close();
		}
		else if (timer > 0) timer--;
		super.update(elapsed);
	}
	
	override public function close():Void 
	{
		FlxTween.tween(back.scale, { y:0 }, 0.2);
		FlxTween.tween(back, { y:FlxG.height }, 0.2);
		FlxTween.tween(actor, { x: -60, angle: -45 }, 0.2);
		for (i in 0...text.length) FlxTween.tween(text.members[i], { y:text.members[i].y - 16, alpha:0 }, 0.004 * i + 0.01);
		new FlxTimer().start(0.3, reallyClose);
	}
	
	function reallyClose(t:FlxTimer):Void
	{
		super.close();
	}
	
}