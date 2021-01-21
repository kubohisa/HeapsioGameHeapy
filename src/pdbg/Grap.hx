package pdbg;

class Grap {
	public static var parent: h2d.Scene;
	public static var engine: h3d.Engine;
	public static var dad: h2d.Object;
	
	static var tile: Map<String, h2d.Tile> = [];
	
	static var radiPi: Float = Math.PI / 180;
	
	// Seting.
	public static var dispX: Int = 960; // PS Vita size.
	public static var dispY: Int = 544;
	
	// Grap.
	public static function init(p: h2d.Scene, e: h3d.Engine) {
		parent = p;
		engine = e;
		
		parent.defaultSmooth = true;
		backgroundColor(0xff000000);
		makeDisp();
	}
	
	public static function end() {
		tileClear();
		tile = null;
		dad.remove();
		dad = null;
	}
	
	// Display.
	public static function makeDisp() {
		dad = new h2d.Object(parent);
	}
	
	public static function clearDisp() {
		dad.remove();
		makeDisp();
	}
	
	public static function resize() {
		parent.scaleMode = ScaleMode.LetterBox(dispX, dispY, false); 
	}
	
	public static function backgroundColor(c: Int) {
		engine.backgroundColor = c; 
	}
	
	public static function windowTitle(t: String) {
		//@:privateAccess hxd.Window.getInstance().window.title = t; 
	}
	
	// Push DELETE to Full Screen.
	public static function fullScreen() {
		if (hxd.Key.isReleased(hxd.Key.DELETE)) {
			engine.fullScreen = !engine.fullScreen;
		}
		if (hxd.Key.isDown(hxd.Key.ESCAPE)) {
			hxd.System.exit();
		}
	}
	
	// Tiles.
	public static function tileLoad(name: String, file: String) {
		tile[name] = hxd.Res.loader.load("images/"+file).toTile();
	}
	
	public static function tileClear() {
		tile = [];
	}
	
	// Fade.
	public static function fader(c: Int, a: Int) {
		var obj = new h2d.Object(dad);
		new h2d.Bitmap(h2d.Tile.fromColor(c, dispX, dispY, 1 - a / 100), obj);
		
		return;
	}
	
	// Object.
	public static function objectAlpha(obj: h2d.Object, a: Float) {
		obj.alpha = a;
	}
	
	public static function objectBlur(obj: h2d.Object, a: Float) {
		obj.filter = new h2d.filter.Blur(a);
	}
	
	public static function objectRotate(obj: h2d.Object, r: Float) {
		obj.rotate(radiPi * r);
	}
	
	// Copy.
	public static function sprite(name: String, x: Float, y: Float) : h2d.Object {
		var obj = new h2d.Object(dad);
		var t = tile[name];
		t = t.center();
		new h2d.Bitmap(t, obj);

		obj.y = y + (t.height / 2);
		obj.x = x + (t.width / 2);
				
		return obj;
	}
	
	public static function spriteDx(name: String, x: Float, y: Float, dx: Float, dy: Float, ?r: Float)  :h2d.Object {
		var obj = new h2d.Object(dad);

		var t = tile[name];
		t = t.center();
		new h2d.Bitmap(t, obj);
		
		obj.scaleX = dx;
		obj.scaleY = dy;
		obj.y = y + (obj.getSize().height / 2);
		obj.x = x + (obj.getSize().width / 2);
		
		if (r != null) {
			obj.rotate(radiPi * r);
		}
		
		return obj;
	}
	
	public static function copy(name: String, srcX: Float, srcY: Float, w: Float, h: Float, dstX: Float, dstY: Float) : h2d.Object {
		var obj = new h2d.Object(dad);
		var t = tile[name].sub(srcX, srcY, w, h, 1, 1);
		t = t.center();
		new h2d.Bitmap(t, obj);

		obj.y = dstX + (obj.getSize().height / 2);
		obj.x = dstY + (obj.getSize().width / 2);
				
		return obj;
	}
	
	public static function copyDx(name: String, srcX: Float, srcY: Float, w: Float, h: Float, dx: Float, dy: Float, dstX: Float, dstY: Float) : h2d.Object {
		var obj = new h2d.Object(dad);
		var t = tile[name].sub(srcX, srcY, w, h, 1, 1);
		t = t.center();
		new h2d.Bitmap(t, obj);

		obj.scaleX = dx;
		obj.scaleY = dy;
		obj.y = dstX + (obj.getSize().height / 2);
		obj.x = dstY + (obj.getSize().width / 2);
				
		return obj;
	}
	
	// Font.
	public static function font(text: String, x: Float, y: Float, size: Int) {
		// 8bit, xml, png
		var obj = new h2d.Object(dad);
		var tf = new h2d.Text(hxd.Res.fonts.Font100dot.toSdfFont(size, 0, 0.5, 0.5), obj);
		tf.text = text;
		tf.rotation = 3.1416;
		tf.x = x;
		tf.y = y;
	}
	
	// System.
	public static function error(text: String) {
		fader(0xff38b48b, 0);
		font("Error: "+text, 0, 30, 26);
	}
	
	static var fpsCounter: Int = 1;
	static var fpsNow: Float = 0;

	public static var fpsTime: Float;
	static var fpsHold: Float;
	
	// Remake.
	public static function fps() {
		var obj = new h2d.Object(dad);
		new h2d.Bitmap(h2d.Tile.fromColor(0xff000000, dispX, 30, 0.6), obj);

		var t = Date.now().getTime();
		if (fpsCounter == 60) {
			fpsNow = 1000 - fpsHold / 60;

			fpsCounter = 1;
			fpsHold = t - fpsTime;
		} else {
			fpsCounter++;
			fpsHold += t - fpsTime;
		}
		fpsTime = t;
		
		font("FPS: " + fpsNow, 0, 0, 26);
	}
}
