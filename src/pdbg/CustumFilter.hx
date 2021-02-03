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

	public static function antiAliasing(obj:h2d.Object) {
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
		@param var height:Float;
		function fragment() {
			var edge:Float = 0.6;

			var pixelColor:Vec4 = texture.get(input.uv);
			var pc:Float = (pixelColor.r + pixelColor.g + pixelColor.b) / 3;

			var flag = 0;

			for (y in -1...1) {
				for (x in -1...1) {
					if (x == 0 && y == 0)
						continue;

					var a:Vec4 = colorGet(x, y);
					var c:Float = (a.r + a.g + a.b) / 3;

					if (pc == c)
						continue;
					if (abs(pc - c) >= edge) {
						flag = 1;
						break;
					}
				}
			}

			if (flag == 0) {
				output.color = pixelColor;
			} else {
				// Blur.
				var sc:Vec4 = colorGet(-1, 0) * 0.25;
				sc += colorGet(1, 0) * 0.25;
				sc += colorGet(0, -1) * 0.25;
				sc += colorGet(0, 1) * 0.25;

				var sc1:Vec4 = colorGet(-1, -1) * 0.25;
				sc1 += colorGet(1, -1) * 0.25;
				sc1 += colorGet(-1, 1) * 0.25;
				sc1 += colorGet(1, 1) * 0.25;

				sc = pixelColor * 0.5 + sc * 0.33 + sc1 * 0.17;
				output.color = vec4(sc.r, sc.g, sc.b, 1.0);
			}
		}
		function colorGet(x:Int, y:Int):Vec4 {
			return texture.get(input.uv + vec2(x / width, y / height));
			//return texture.get(vec2(x / width, y / height));
		}
	}

	public function new(obj:h2d.Object) {
		super();
		width = obj.getSize().width;
		height = obj.getSize().height;
	}
}
