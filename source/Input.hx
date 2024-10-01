package;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

typedef Bind =
{
	key:Array<FlxKey>,
	gamepad:Array<FlxGamepadInputID>
}

class Input
{
	public static var binds(default, null):Map<String, Bind> = [
		'down' => {key: [DOWN, S], gamepad: [DPAD_DOWN, LEFT_SHOULDER]},
		'right' => {key: [RIGHT, D], gamepad: [DPAD_RIGHT, RIGHT_TRIGGER]},
		'up' => {key: [UP, W], gamepad: [DPAD_UP, RIGHT_SHOULDER]},
		'left' => {key: [LEFT, A], gamepad: [DPAD_LEFT, LEFT_TRIGGER]},
		'accept' => {key: [ENTER, SPACE], gamepad: [A, START]},
		'exit' => {key: [ESCAPE, BACKSPACE], gamepad: [B, BACK]},
	];

	public static function justPressed(tag:String):Bool
	{
		final bind:Null<Bind> = binds.get(tag);

        if (FlxG.gamepads.lastActive != null) {
            for (b in bind)
		        if (FlxG.gamepads.checkStatus(b.gamepad, JUST_PRESSED))
			        return (binds.exists(tag)) ? true : FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_PRESSED);
        } else {
            for (b in bind)
                if (FlxG.keys.checkStatus(b.key, JUST_PRESSED))
			        return (binds.exists(tag)) ? true : FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_PRESSED);
        }

		return false;
	}

	public static function pressed(tag:String):Bool
	{
		final bind:Null<Bind> = binds.get(tag);

        if (FlxG.gamepads.lastActive != null) {
            for (b in bind)
		        if (FlxG.gamepads.checkStatus(b.gamepad, PRESSED))
			        return (binds.exists(tag)) ? true : FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), PRESSED);
        } else {
            for (b in bind)
                if (FlxG.keys.checkStatus(b.key, PRESSED))
			        return (binds.exists(tag)) ? true : FlxG.keys.checkStatus(FlxKey.fromString(tag), PRESSED);
        }

		return false;
	}

	public static function justReleased(tag:String):Bool
	{
		final bind:Null<Bind> = binds.get(tag);

        if (FlxG.gamepads.lastActive != null) {
            for (b in bind)
		        if (FlxG.gamepads.checkStatus(b.gamepad, JUST_RELEASED))
			        return (binds.exists(tag)) ? true : FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_RELEASED);
        } else {
            for (b in bind)
                if (FlxG.keys.checkStatus(b.key, JUST_RELEASED))
			        return (binds.exists(tag)) ? true : FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_RELEASED);
        }

		return false;
	}
}