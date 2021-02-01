package pdbg;

// Custum filter(Test).

/*
	カスタムフィルターは、heaps.ioのフィルターとは共存できません
	どちらかを実行すると、片方はリセットされます

	カスタムフィルターは、一つのオブジェクトへ対して一つしか実行できません

	カスタムフィルターを複数使う場合はGroupクラスを使います
	obj.filter = new h2d.filter.Group([pdbg.CustumFilter.colorInversion(), pdbg.CustumFilter.colorInversion()]);
 */
class CustumFilter {
	public static function colorInversion() {
		return new h2d.filter.Shader(new PdbgFilterInversion());
	}

	public static function colorMonochrome() {
		return new h2d.filter.Shader(new PdbgFilterMonochrome());
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

class PdbgFilterMonochrome extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture:Sampler2D;
		function fragment() {
			pixelColor = texture.get(input.uv);

			var c = (pixelColor.r + pixelColor.g + pixelColor.b) / 3;

			pixelColor.r = c;
			pixelColor.g = c;
			pixelColor.b = c;
		}
	}
}
