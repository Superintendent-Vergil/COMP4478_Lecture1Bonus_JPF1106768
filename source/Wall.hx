package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

class Wall extends FlxSprite
{
	// Variables
	public function new(x:Float = 0, y:Float = 0, color:FlxColor = FlxColor.BLUE)
	{
		super(x, y);
		makeGraphic(16, 16, color);
		immovable = true;
		solid = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
