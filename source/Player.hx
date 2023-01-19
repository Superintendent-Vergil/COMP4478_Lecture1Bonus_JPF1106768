package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.FlxDirectionFlags;

class Player extends FlxSprite
{
	// Variables
	var moveSpeed:Int = 1;

	public var movingToNextTile:Bool;

	var moveDirection:FlxDirectionFlags;
	var currPlayerPos:FlxPoint;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(16, 16, FlxColor.RED);
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement()
	{
		if (!PlayState.goalReached) // Movement
		{
			currPlayerPos = getPosition();
			if (movingToNextTile)
			{
				switch (moveDirection)
				{
					case LEFT:
						x -= moveSpeed;
					case RIGHT:
						x += moveSpeed;
					case UP:
						y -= moveSpeed;
					case DOWN:
						y += moveSpeed;
					case _:
				}
			}

			// Check if the player has now reached the next block
			if ((x % 16 == 0) && (y % 16 == 0))
			{
				movingToNextTile = false; // Stop movement
			}
			if (!movingToNextTile)
			{
				if (FlxG.keys.pressed.LEFT)
					move(LEFT);
				else if (FlxG.keys.pressed.RIGHT)
					move(RIGHT);
				else if (FlxG.keys.pressed.UP)
					move(UP);
				else if (FlxG.keys.pressed.DOWN)
					move(DOWN);
			}
		}

		if (x < 16 || x > 96 || y < 16 || y > 96)
			stopMoving();
	}

	function move(direction:FlxDirectionFlags)
	{
		if (!movingToNextTile)
		{
			moveDirection = direction;
			movingToNextTile = true;
		}
	}

	public function stopMoving()
	{
		setPosition(currPlayerPos.x, currPlayerPos.y); // Reset player position
		movingToNextTile = false;
	}
}
