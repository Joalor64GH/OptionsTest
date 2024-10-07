package;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.gamepad.FlxGamepad;
import flixel.input.keyboard.FlxKey;

typedef Bind =
{
	key:Array<FlxKey>,
	gamepad:Array<FlxGamepadInputID>
}

class Input
{
	public static var binds:Map<String, Bind> = [
		'down' => {key: [DOWN, S], gamepad: [DPAD_DOWN, LEFT_SHOULDER]},
		'right' => {key: [RIGHT, D], gamepad: [DPAD_RIGHT, RIGHT_TRIGGER]},
		'up' => {key: [UP, W], gamepad: [DPAD_UP, RIGHT_SHOULDER]},
		'left' => {key: [LEFT, D], gamepad: [DPAD_LEFT, LEFT_TRIGGER]},
		'accept' => {key: [ENTER, SPACE], gamepad: [A, START]},
		'exit' => {key: [ESCAPE, BACKSPACE], gamepad: [B, BACK]},
	];

	public static function justPressed(tag:String):Bool
	{
		if (!binds.exists(tag))
            return null;

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad != null) {
            for (i in 0...binds[tag].gamepad.length)
		        if (gamepad.checkStatus(binds[tag].gamepad[i], JUST_PRESSED))
			        return true /*FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_PRESSED)*/;
        } else {
            for (i in 0...binds[tag].key.length)
                if (FlxG.keys.checkStatus(binds[tag].key[i], JUST_PRESSED))
			        return true /*FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_PRESSED)*/;
        }

		return false;
	}

	public static function pressed(tag:String):Bool
	{
        if (!binds.exists(tag))
            return null;

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad != null) {
            for (i in 0...binds[tag].gamepad.length)
		        if (gamepad.checkStatus(binds[tag].gamepad[i], PRESSED))
			        return true /*FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_PRESSED)*/;
        } else {
            for (i in 0...binds[tag].key.length)
                if (FlxG.keys.checkStatus(binds[tag].key[i], PRESSED))
			        return true /*FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_PRESSED)*/;
        }

		return false;
	}

	public static function justReleased(tag:String):Bool
	{
        if (!binds.exists(tag))
            return null;

        var gamepad:FlxGamepad = FlxG.gamepads.lastActive;

        if (gamepad != null) {
            for (i in 0...binds[tag].gamepad.length)
		        if (gamepad.checkStatus(binds[tag].gamepad[i], JUST_RELEASED))
			        return true /*FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_PRESSED)*/;
        } else {
            for (i in 0...binds[tag].key.length)
                if (FlxG.keys.checkStatus(binds[tag].key[i], JUST_RELEASED))
			        return true /*FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_PRESSED)*/;
        }

		return false;
	}
}