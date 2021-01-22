package pdbg;

import haxe.Int64;

class Rand {
	static var seed:Int64;

	// Api.
	public static function init(?a:Int) {
		if (a != null && a != 0) {
			seed = a;
			return;
		}

		seed = 0;
		while (seed == 0) {
			seed = Int64.fromFloat(Date.now().getTime());
		}
		reset();
	}

	public static function reset() {
		var a = (Date.now().getSeconds() & 0xF) | 1;
		seed = seed ^ (seed >> a);

		if (seed == 0) {
			init();
		}
	}

	public static function next(?a:Int):Int {
		seed = seed ^ (seed << 13);
		seed = seed ^ (seed >> 7);
		seed = seed ^ (seed << 17);

		// 型変換のための丸めとプラス処理
		if (a == null) {
			return Int64.toInt(seed & 0x7FFFFFFF);
		} else {
			return Int64.toInt(seed & 0x7FFFFFFF) % a;
		}
	}
}
