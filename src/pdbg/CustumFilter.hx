package pdbg;

// Custum filter(Test).

/*
	カスタムフィルターは、heaps.ioのフィルターとは共存できません
	どちらかを実行すると、片方はリセットされます

	カスタムフィルターは、一つのオブジェクトへ対して一つしか実行できません
 */
class CustumFilter {
	public static function colorInversion(o:h2d.Object) {
		o.filter = new h2d.filter.Shader(new PdbgFilterInversion());
	}
}

class PdbgFilterInversion extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture:Sampler2D;
		function fragment() {
			pixelColor = texture.get(input.uv);

			pixelColor.r = 1 - pixelColor.r;
			pixelColor.g = 1 - pixelColor.g;
			pixelColor.b = 1 - pixelColor.b;
		}
	}
}
