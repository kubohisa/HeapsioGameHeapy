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

	public static function colorEdge(obj:h2d.Object) {
		return new h2d.filter.Shader(new PdbgFilterEdge(obj));
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
			var pixelColor:Vec4 = texture.get(input.uv);
			var pc:Float = (pixelColor.r + pixelColor.g + pixelColor.b) / 3;

			var ac:Float = 0.0;

			for (y in -1...1) {
				for (x in -1...1) {
					if (x == 0 && y == 0)
						continue;

					var a:Vec4 = texture.get(input.uv + vec2(x / width, y / width));
					var c:Float = (a.r + a.g + a.b) / 3;

					if (pc == c)
						continue;
					if (abs(pc - c) >= 0.6) {
						ac = 1.0;
						break;
					}
				}
			}

			output.color = vec4(ac, ac, ac, 1.0);
		}
	}

	public function new(obj:h2d.Object) {
		super();
		width = obj.getSize().width;
	}
}
