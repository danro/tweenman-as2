
import com.tweenman.BaseProp;

class com.tweenman.FrameProp extends BaseProp {

	function init () {
		if (typeof(target) != "movieclip") return tween.typeError(id, "MovieClip");
		start = target._currentframe;
		if (typeof(value) == "number") {
			change = value - start;
		} else {
			change = Number(value);
		}
	}

	function update ($position) {
		var newFrame:Number = int(start + ($position * change));
		target.gotoAndStop(newFrame > 0 ? newFrame : 1);
	}
}