package;

import pdbg.*;
import hxd.Res;

class Main extends hxd.App {
	static function main() {
		new Main();
    	}
	
	override public function onResize() {
		super.onResize();
		pdbg.Grap.resize();
	}
	
	override function init() {
		// res init.
		#if hl
			hxd.res.Resource.LIVE_UPDATE = true;
			hxd.Res.initLocal();
		#else
			hxd.Res.initEmbed();
		#end
		
		// Rand init.
		pdbg.Rand.init();
		
		// Loop seting.
		pdbg.Loop.changeMode("Title");
		
		// grap init.
		pdbg.Grap.init(s2d, engine);			// Global s2d.
		//pdbg.Grap.windowTitle("abcdefg");
		onResize();
		
		// Mouse init.
		pdbg.Mouse.init();
		
		// Pad init.
		pdbg.Pad.init();
	}
	
	override function update(dt: Float) {
		super.update(dt);
		pdbg.Loop.loop();
	}
}
