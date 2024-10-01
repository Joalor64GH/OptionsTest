package;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

typedef Bind =
{
	key:FlxKey,
	gamepad:FlxGamepadInputID
}

class Input
{
	public static var binds:Map<String, Bind> = [
		'down' => {key: DOWN, gamepad: DPAD_DOWN},
		'right' => {key: RIGHT, gamepad: DPAD_RIGHT},
		'up' => {key: UP, gamepad: DPAD_UP},
		'left' => {key: LEFT, gamepad: DPAD_LEFT},
		'accept' => {key: ENTER, gamepad: A},
		'exit' => {key: ESCAPE, gamepad: B},
	];

	public static function justPressed(tag:String):Bool
	{
		final bind:Null<Bind> = binds.get(tag);

        if (FlxG.gamepads.lastActive != null) {
		    if (FlxG.gamepads.anyJustPressed(bind.gamepad))
			    return (binds.exists(tag)) ? true : FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_PRESSED);
        } else {
            if (FlxG.keys.checkStatus(bind.key, JUST_PRESSED))
			    return (binds.exists(tag)) ? true : FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_PRESSED);
        }

		return false;
	}

	public static function pressed(tag:String):Bool
	{
        final bind:Null<Bind> = binds.get(tag);

        if (FlxG.gamepads.lastActive != null) {
		    if (FlxG.gamepads.anyJustPressed(bind.gamepad))
			    return (binds.exists(tag)) ? true : FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), PRESSED);
        } else {
            if (FlxG.keys.checkStatus(bind.key, PRESSED))
			    return (binds.exists(tag)) ? true : FlxG.keys.checkStatus(FlxKey.fromString(tag), PRESSED);
        }

		return false;
	}

	public static function justReleased(tag:String):Bool
	{
        final bind:Null<Bind> = binds.get(tag);

        if (FlxG.gamepads.lastActive != null) {
		    if (FlxG.gamepads.anyJustPressed(bind.gamepad))
			    return (binds.exists(tag)) ? true : FlxG.gamepads.checkStatus(FlxGamepadInputID.fromString(tag), JUST_RELEASED);
        } else {
            if (FlxG.keys.checkStatus(bind.key, JUST_RELEASED))
			    return (binds.exists(tag)) ? true : FlxG.keys.checkStatus(FlxKey.fromString(tag), JUST_RELEASED);
        }

		return false;
	}
}