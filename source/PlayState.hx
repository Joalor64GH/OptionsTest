package;

class PlayState extends FlxState {
	override public function create() {
		super.create();

		SaveData.init();

		var text = new FlxText(0, 0, 0, "Hello World", 20);
		text.screenCenter();
		add(text);
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (Input.justPressed('o'))
			FlxG.switchState(new OptionsState());

		if (Input.anyJustPressed(['left', 'right']))
			FlxG.switchState(new OptionsState());
	}
}