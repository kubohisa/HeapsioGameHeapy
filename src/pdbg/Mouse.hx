package pdbg;

class Mouse {
	static var interaction: h2d.Interactive;
	
	public static var x: Int;
	public static var y: Int;
	public static var click: String;
	
	static var push: Int;
	
	public static function init() {
		interaction = new h2d.Interactive(pdbg.Grap.dispX, pdbg.Grap.dispY, pdbg.Grap.parent);
		
		interaction.onRelease = function(event : hxd.Event) {
			// ウィンドウを拡大すると小数点単位の誤差が出るので丸めている
			x = Math.round(event.relX);
			y = Math.round(event.relY);
			push = 0;
			click = "UP";
			//trace("Rel:" + x + ":" + y);
		}
			
		interaction.onPush = function(event : hxd.Event) {
			x = Math.round(event.relX);
			y = Math.round(event.relY);
			push = 1;
			click = "DOUN";
			//trace("pre:" + x + ":" + y);
		}
		
		interaction.onMove = function(event : hxd.Event) {
			if (push == 1) {
				x = Math.round(event.relX);
				y = Math.round(event.relY);
				click = "MOVE";
				//trace("move:" + x + ":" + y);
			}
		}
	}
	
	public static function reset() {
		click = "";
	}
}
