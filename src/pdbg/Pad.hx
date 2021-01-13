package pdbg;

class Pad {
	static var pad : hxd.Pad;

	public static var padX: Float;
	public static var padY: Float;
	public static var button: Map<String, Float> = [];
	public static var buttonPrev: Map<String, Float> = [];

	public static function init() {
		hxd.Pad.wait(onPad);
	}

	public static function end() {
		button = [];
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

		buttonPrev = [
			"A" => button["A"],
			"B" => button["B"],
			"X" => button["X"],
			"Y" => button["Y"],
			"RB" => button["RB"],
			"LB" => button["LB"],
			"start" => button["start"],
			"back" => button["back"],
			"analogClick" => button["analogClick"],
			"ranalogClick" => button["ranalogClick"]
		];

		button = [
			"A" => pad.values[ conf.A ],
			"B" => pad.values[ conf.B ],
			"X" => pad.values[ conf.X ],
			"Y" => pad.values[ conf.Y ],
			"RB" => pad.values[ conf.RB ],
			"RT" => pad.values[ conf.RT ],
			"LB" => pad.values[ conf.LB ],
			"LT" => pad.values[ conf.LT ],
			"start" => pad.values[ conf.start ],
			"back" => pad.values[ conf.back ],
			"analogClick" => pad.values[ conf.analogClick ],
			"ranalogClick" => pad.values[ conf.ranalogClick ]
		];
	}
}
