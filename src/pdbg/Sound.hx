package pdbg;

class Sound {

	//　手探りで製作中

	static var musicChannel: hxd.snd.Channel;
	static var musicVol: Int = 100;

	public static function musicPlay(file: String) {
		var musicRes: hxd.res.Sound = hxd.Res.loader.load("musics/" + file + ".ogg").toSound();

		if(musicRes != null){
			musicChannel = musicRes.play(true, musicVol / 100);
		}
	}

	public static function musicQueue(file: String) {
		var sound: hxd.res.Sound = hxd.Res.loader.load("musics/" + file + ".ogg").toSound();

		if(sound != null){
			musicChannel.queueSound(sound);
		}
	}

	public static function musicPause()
	{
		if (musicChannel != null) {
			musicChannel.pause = !musicChannel.pause;
		}
	}

	public static function musicStop()
	{
		if (musicChannel != null) {
			musicChannel.stop();
		}
	}

	public static function musicFade(volume: Float, time: Float)
	{
		if (volume >= 0 && volume <= 100) {
			if (musicChannel != null) {
				musicChannel.fadeTo(volume / 100, time);
			}
		}
	}

	public static function musicVolume(volume: Int)
	{
		if (volume >= 0 && volume <= 100) {
			musicVol = volume;

			if (musicChannel != null) {
				musicChannel.volume = musicVol / 100;
			}
		}
	}
}
