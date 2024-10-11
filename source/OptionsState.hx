package;

import Option;

class OptionsState extends FlxState {
	var options:Array<Option> = [
        new Option('Boolean', "This is a boolean.", OptionType.Toggle, SaveData.settings.option1),
        new Option('Int', "This is an integer.", OptionType.Integer(1, 10, 1), SaveData.settings.option2),
        new Option('Options', "These are choices.", OptionType.Choice(['easy', 'medium', 'hard']), SaveData.settings.option3),
        new Option('Float', "This is a decimal.", OptionType.Decimal(0, 1, 0.1), SaveData.settings.option4)
    ];
	var grpOptions:FlxTypedGroup<FlxText>;
	var curSelected:Int = 0;
	var description:FlxText;

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

		description = new FlxText(0, FlxG.height * 0.1, FlxG.width * 0.9, '', 28);
		description.setFormat(Paths.font("vcr.ttf"), 28, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		description.screenCenter(X);
		description.scrollFactor.set();
		add(description);

		changeSelection();

		FlxG.camera.follow(camFollow, LOCKON, 0.25);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
			changeSelection(FlxG.keys.justPressed.UP ? -1 : 1);

        if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.LEFT) {
            if (options[curSelected].type != OptionType.Function)
			    changeValue(FlxG.keys.justPressed.RIGHT ? 1 : -1);
        }

        if (FlxG.keys.justPressed.ENTER) {
			final option:Option = options[curSelected];
            if (option != null)
                option.execute();
        }

		if (FlxG.keys.justPressed.ESCAPE) {
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

		var option = options[curSelected];

		if (option.desc != null) {
			description.text = option.desc;
			description.screenCenter(X);
		}
	}

    private function changeValue(direction:Int = 0):Void {
		final option:Option = options[curSelected];

		if (option != null) {
			option.changeValue(direction);

			grpOptions.forEach(function(txt:FlxText):Void {
				if (txt.ID == curSelected)
					txt.text = option.toString();
			});
		}
	}
}