package;

import Option;

class OptionsState extends FlxState {
	var options:Array<Option> = [
        new Option('Boolean', OptionType.Toggle, SaveData.settings.option1),
        new Option('Int', OptionType.Integer(1, 10, 1), SaveData.settings.option2),
        new Option('Options', OptionType.Choice('easy', 'medium', 'hard'), SaveData.settings.option3),
        new Option('Float', OptionType.Decimal(0, 1, 0.1), SaveData.settings.option4)
    ];
	var grpOptions:FlxTypedGroup<FlxText>;
	var curSelected:Int = 0;

	var camFollow:FlxObject;

	override function create() {
		super.create();

        options.push(new Option('Exit', OptionType.Function, function():Void {
            Sys.exit(0);
        }));

		camFollow = new FlxObject(80, 0, 0, 0);
		camFollow.screenCenter(X);

		grpOptions = new FlxTypedGroup<FlxText>();
		add(grpOptions);

		for (i in 0...options.length) {
			var optionTxt:FlxText = new FlxText(20, 20 + (i * 50), 0, options[i].toString(), 32);
			optionTxt.setFormat(Paths.font('vcr.ttf'), 60, FlxColor.WHITE, FlxTextAlign.LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
			optionTxt.ID = i;
			grpOptions.add(optionTxt);
		}

		changeSelection();

		FlxG.camera.follow(camFollow, LOCKON, 0.25);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (Input.justPressed('up') || Input.justPressed('down'))
			changeSelection(Input.justPressed('up') ? -1 : 1);

        if (Input.justPressed('right') || Input.justPressed('left')) {
            if (options[curSelected].type != OptionType.Function)
			    changeValue(Input.justPressed('right') ? 1 : -1);
        }

        if (Input.justPressed('accept')) {
            if (options[curSelected] != null)
                option.execute();
        }

		if (Input.justPressed('exit')) {
			FlxG.switchState(new PlayState());
			SaveData.saveSettings();
		}
	}

	private function changeSelection(change:Int = 0) {
		curSelected = FlxMath.wrap(curSelected + change, 0, options.length - 1);
		grpOptions.forEach(function(txt:FlxText) {
			txt.alpha = (txt.ID == curSelected) ? 1 : 0.6;
			if (txt.ID == curSelected)
				camFollow.y = txt.y;
		});
	}

    private function changeValue(direction:Int = 0):Void {
		final option:Option = options[selected];

		if (option != null) {
			option.changeValue(direction);

			grpOptions.forEach(function(txt:FlxText):Void {
				if (txt.ID == curSelected)
					txt.text = option.toString();
			});
		}
	}
}