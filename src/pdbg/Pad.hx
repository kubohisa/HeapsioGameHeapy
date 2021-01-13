package pdbg;

class Pad {
	static var pad : hxd.Pad;

	public static var padX: Float;
	public static var padY: Float;

	public static function init() {
		hxd.Pad.wait(onPad);
	}

	static function onPad(p: hxd.Pad) {
		pad = p;

		//if( !p.connected ) throw "Pad not connected ?";
    	
    	p.onDisconnect = function(){
    		//if( p.connected ) throw "OnDisconnect called while still connected ?";
    	}
	}

	// https://heaps.io/api/hxd/Pad.html
	public static function get() {
		var conf = pad.config;

		padX = Std.int(pad.values[ conf.analogX ]);
		if (padX == 0) {
			if (Std.int(pad.values[ conf.dpadLeft ]) == 1) {
				padX = -1;
			} else if (Std.int(pad.values[ conf.dpadRight ]) == 1) {
				padX = 1;
			}
		}


		padY = -Std.int(pad.values[ conf.analogY ]);
		if (padY == 0) {
			if (Std.int(pad.values[ conf.dpadUp ]) == 1) {
				padY = -1;
			} else if (Std.int(pad.values[ conf.dpadDown ]) == 1) {
				padY = 1;
			}
		}

		//trace(padY);
	}
}
