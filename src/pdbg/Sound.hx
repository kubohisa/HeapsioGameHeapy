package pdbg;

class Sound {
	// 　手探りで製作中
	static var manager:hxd.snd.Manager;

	static var musicChGroup:hxd.snd.ChannelGroup;
	static var seChGroup:hxd.snd.ChannelGroup;

	// init.
	public static function init() {
		manager = hxd.snd.Manager.get();
		masterVolume(masterVol);
		manager.masterSoundGroup.maxAudible = 6;

		musicChGroup = new hxd.snd.ChannelGroup("music");
		seChGroup = new hxd.snd.ChannelGroup("se");
	}

	public static function end() {
		clean();
		seVol = null;
		se = null;
	}

	// Master.
	static var masterVol:Int = 100;

	public static function masterVolume(volume:Int) {
		if (volume >= 0 && volume <= 100) {
			masterVol = volume;
			manager.masterVolume = volume / 100;
		}
	}

	public static function clean() {
		manager.stopAll();
		manager.cleanCache();
		seVol = [];
		se = [];
	}

	// Back ground Mauic.
	static var musicChannel:hxd.snd.Channel;
	static var musicVol:Int = 100;

	public static function musicPlay(file:String) {
		var sound:hxd.res.Sound = hxd.Res.loader.load("musics/" + file + ".ogg").toSound();

		if (sound != null) {
			musicChannel = sound.play(true, musicVol / 100, musicChGroup);
		}
	}

	public static function musicQueue(file:String) {
		var sound:hxd.res.Sound = hxd.Res.loader.load("musics/" + file + ".ogg").toSound();

		if (sound != null) {
			musicChannel.queueSound(sound);
		}
	}

	public static function musicPause() {
		if (musicChannel != null) {
			musicChannel.pause = !musicChannel.pause;
		}
	}

	public static function musicStop() {
		if (musicChannel != null) {
			musicChannel.stop();
		}
	}

	public static function musicFade(volume:Float, time:Float) {
		if (volume >= 0 && volume <= 100) {
			if (musicChannel != null) {
				musicChannel.fadeTo(volume / 100, time);
			}
		}
	}

	public static function musicVolume(volume:Int) {
		if (volume >= 0 && volume <= 100) {
			musicVol = volume;

			if (musicChannel != null) {
				musicChannel.volume = musicVol / 100;
			}
		}
	}

	// SE.
	// 効果音のデータが無いのでデバッグ出来てない
	static var se:Map<String, hxd.snd.Channel> = [];
	static var seVol:Map<String, Int>;
	static var seMasterVol:Int = 100;

	public static function sePlay(name:String, file:String) {
		var sound:hxd.res.Sound = hxd.Res.loader.load("se/" + file + ".ogg").toSound();

		if (seVol[name] == null)
			seVol[name] = 100;

		if (sound != null) {
			se[name] = sound.play(true, seVol[name] / 100, seChGroup);
		}
	}

	public static function sePause(name:String) {
		if (musicChannel != null) {
			se[name].pause = !se[name].pause;
		}
	}

	public static function seStop(name:String) {
		if (se[name] != null) {
			se[name].stop();
		}
	}

	public static function seVolume(name:String, volume:Int) {
		if (volume >= 0 && volume <= 100) {
			seVol[name] = volume;
			se[name].volume = volume / 100;
		}
	}

	public static function seMasterVolume(volume:Int) {
		if (volume >= 0 && volume <= 100) {
			seMasterVol = volume;
			seChGroup.volume = volume / 100;
		}
	}
}
