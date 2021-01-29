package pdbg;

class Filter {
	static var m:h3d.Matrix;

	public static function init() {
		m = new h3d.Matrix();
		m.identity();
	}

	public static function set(o:h2d.Object) {
		o.filter = new h2d.filter.ColorMatrix(m);
	}

	// URL: https://heaps.io/api/h3d/Matrix.html
	public static function colorContrast(c:Float) {
		m.colorContrast(c);
	}

	public static function colorGain(c:Int, a:Float) {
		m.colorGain(c, a);
	}

	public static function colorHue(h:Float) {
		m.colorHue(h);
	}

	public static function colorLightness(l:Float) {
		m.colorLightness(l);
	}

	public static function colorSaturate(s:Float) {
		m.colorSaturate(s);
	}
}
