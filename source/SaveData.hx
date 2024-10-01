package;

@:structInit class SaveSettings {
	public var option1:String = true;
	public var option2:Int = 1;
	public var option3:Int = 'hard';
	public var option4:Float = 0;
	public var keyboardBinds:Array<FlxKey> = [LEFT, DOWN, UP, RIGHT, ENTER, ESCAPE, SPACE];
	public var gamepadBinds:Array<FlxGamepadInputID> = [DPAD_LEFT, DPAD_DOWN, DPAD_UP, DPAD_RIGHT, A, B];
}

class SaveData {
	public static var settings:SaveSettings = {};

	public static function init() {
		for (key in Reflect.fields(settings))
			if (Reflect.field(FlxG.save.data, key) != null)
				Reflect.setField(settings, key, Reflect.field(FlxG.save.data, key));
	}

	public static function saveSettings() {
		for (key in Reflect.fields(settings))
			Reflect.setField(FlxG.save.data, key, Reflect.field(settings, key));

		FlxG.save.flush();

		trace('settings saved!');
	}

	public static function eraseData() {
		FlxG.save.erase();
		init();
	}
}