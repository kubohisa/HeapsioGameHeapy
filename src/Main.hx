package;

import pdbg.*;
import hxd.Res;

class Main extends hxd.App {
	static function main() {
		new Main();
	}

	override function init() {
		// res init.
		#if hl
		hxd.res.Resource.LIVE_UPDATE = true;
		hxd.Res.initLocal();
		#else
		hxd.Res.initEmbed();
		#end

		// DOS窓を閉じる（exe限定）
		#if debug
		hl.UI.closeConsole();
		#end

		// Init.
		pdbg.Rand.init();
		pdbg.Loop.init();
		pdbg.Grap.init(s2d, engine); // Global s2d.
		pdbg.Mouse.init();
		pdbg.Pad.init();
		pdbg.Sound.init();

		pdbg.Loop.changeMode("Title");
		pdbg.Grap.resize();
		// pdbg.Grap.windowTitle("abcdefg");
	}

	override function update(dt:Float) {
		super.update(dt);
		pdbg.Loop.loop();
	}

	override public function onResize() {
		super.onResize();
		pdbg.Grap.resize();
	}
}
