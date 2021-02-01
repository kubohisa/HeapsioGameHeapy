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

	public static function colorEdge() {
		return new h2d.filter.Shader(new PdbgFilterEdge());
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

class PdbgFilterEdge extends h3d.shader.ScreenShader {
	static var SRC = {
		@param var texture:Sampler2D;
		@param var width:Float;
		function fragment() {
			pixelColor = texture.get(input.uv);
			var pc = (pixelColor.r + pixelColor.g + pixelColor.b) / 3;

			var tf = 1 / width;
			var count = 0;
			var flag = 0;
			var ac:Float = 0.0;
			for (y in -1...1) {
				for (x in -1...1) {
					if (tf * x < 0 || tf * x > 1)
						continue;
					if (tf * y < 0 || tf * y > 1)
						continue;

					var a = texture.get(input.uv + vec2(tf * x, tf * y));
					var c = (a.r + a.g + a.b) / 3;

					if (abs(pc - c) > 0.6) {
						ac = 1.0;
					}
				}
			}

			pixelColor.rgb = vec3(ac);
		}
	}
}
