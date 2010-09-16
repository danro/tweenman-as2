	
import com.tweenman.BaseProp;

class com.tweenman.SoundProp extends BaseProp {

	private var previous:Object;

	function init () {
		/*
		var typeFound:Boolean = false;
		if (target == SoundMixer) {
			typeFound = true;
		} else {
			for each (var soundType:Function in types) {
				if (target is soundType) { typeFound = true; break; }
			}
		}
		if (!typeFound) return tween.typeError(id, "Microphone, NetStream, SimpleButton, SoundChannel, SoundMixer, Sprite");
		if (target.soundTransform == null) target.soundTransform = new SoundTransform();
		previous = target;
		target = target.soundTransform;
		super.init();
		*/
	}

	function update ($position) {
		/*
		target = previous.soundTransform;
		super.update($position);
		previous.soundTransform = target;
		*/
	}
}