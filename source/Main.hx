package;

class Main extends openfl.display.Sprite {
	public final config:Dynamic = {
		gameDimensions: [1280, 720], // Width + Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
		zoom: -1.0, // If -1, zoom is automatically calculated to fit the window dimensions. (Removed from Flixel 5.0.0)
		framerate: 60, // How many frames per second the game should run at.
		initialState: PlayState, // is the state in which the game will start.
		skipSplash: false, // Whether to skip the flixel splash screen that appears in release mode.
		startFullscreen: false // Whether to start the game in fullscreen on desktop targets'
	};

	public function new() {
		super();

		addChild(new FlxGame(config.gameDimensions[0], config.gameDimensions[1], config.initialState, #if (flixel < "5.0.0") config.zoom, #end config.framerate, config.framerate,
			config.skipSplash, config.startFullscreen));
	}
}