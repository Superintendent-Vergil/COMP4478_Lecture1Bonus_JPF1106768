package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDirection;
import flixel.util.FlxDirectionFlags;

class PlayState extends FlxState
{
	// Variables
	var walls:FlxTypedGroup<FlxSprite>;
	var player:Player;
	var goal:FlxSprite;

	public static var goalReached:Bool;

	var successText:FlxText;
	var resetButton:FlxButton;

	override public function create()
	{
		// Setup walls
		add(walls = new FlxTypedGroup<FlxSprite>());
		for (i in 0...11)
		{
			var wall = new Wall();
			walls.add(wall);
		}
		// Position walls
		walls.members[0].setPosition(16, 16);
		walls.members[1].setPosition(32, 16);
		walls.members[2].setPosition(64, 16);
		walls.members[3].setPosition(80, 32);
		walls.members[4].setPosition(48, 48);
		walls.members[5].setPosition(64, 64);
		walls.members[6].setPosition(32, 80);
		walls.members[7].setPosition(64, 80);
		walls.members[8].setPosition(80, 80);
		walls.members[9].setPosition(96, 80);
		walls.members[10].setPosition(32, 96);

		// Setup goal
		goal = new FlxSprite(96, 16);
		goal.makeGraphic(16, 16, FlxColor.LIME);
		add(goal);

		// Setup player
		player = new Player(16, 96);
		add(player);

		// Success Text
		successText = new FlxText(0, 0, "Success!", 14);
		successText.color = FlxColor.LIME;
		successText.screenCenter();
		successText.exists = false;
		add(successText);

		// Reset button
		resetButton = new FlxButton(0, 0, "Reset", resetGame);
		resetButton.screenCenter();
		resetButton.y += 50;
		resetButton.exists = false;
		add(resetButton);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		// Collision
		if (FlxG.overlap(player, walls)) // If player colliding with walls, stop them from doing so
			player.stopMoving();

		// Check if player reached goal when player has reached next tile
		if (FlxG.overlap(player, goal) && !player.movingToNextTile)
		{
			goalReached = true;
			successText.exists = true;
			resetButton.exists = true;
		}
	}

	function resetGame()
	{
		goalReached = false;
		successText.exists = false;
		resetButton.exists = false;
		// Reset player position
		player.setPosition(16, 96);
	}
}
