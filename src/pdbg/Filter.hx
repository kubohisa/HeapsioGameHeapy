package pdbg;

class Filter {
	static var m:h3d.Matrix;

	public static function init() {
		m = new h3d.Matrix();
	}

	public static function set(o:h2d.Object) {
		o.filter = new h2d.filter.ColorMatrix(m);
	}

	// URL: https://heaps.io/api/h3d/Matrix.html
	public static function colorLightness(l:Float) {
		m.colorLightness(l);
	}
}
