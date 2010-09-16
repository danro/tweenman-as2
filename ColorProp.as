
import flash.geom.ColorTransform;
import com.tweenman.MultiProp;
import com.tweenman.HexColorProp;

class com.tweenman.ColorProp extends MultiProp {

	function init () {
		var valid:Boolean = typeof(target) == "movieclip" || target instanceof Button || target instanceof TextField;
		if (!valid) return tween.typeError(id, "MovieClip, Button, TextField");
		defaults = { redMultiplier: 1.0, greenMultiplier: 1.0, blueMultiplier: 1.0, alphaMultiplier: 1.0, 
					 redOffset: 0, greenOffset: 0, blueOffset: 0, alphaOffset: 0, brightness: 0,
					 tintColor: 0x000000, tintMultiplier: 0, burn: 0 };
		if (value != null) {
			if (value.brightness != null) {
				value.redMultiplier = value.greenMultiplier = value.blueMultiplier = 1 - Math.abs(value.brightness);
				value.burn = value.brightness > 0 ? value.brightness : 0;
			}
			if (value.burn != null) value.redOffset = value.greenOffset = value.blueOffset = 256 * value.burn;
			if (value.tintColor != null) {
				if (value.tintMultiplier == null) value.tintMultiplier = 1;
				value.redOffset = (value.tintColor >> 16) * value.tintMultiplier;
				value.greenOffset = ((value.tintColor >> 8) & 0xFF) * value.tintMultiplier;
				value.blueOffset = (value.tintColor & 0xFF) * value.tintMultiplier;
			}
			if (value.tintMultiplier != null) {
				value.redMultiplier = value.greenMultiplier = value.blueMultiplier = 1 - Math.abs(value.tintMultiplier);
			}
		}
		if (value == null) value = defaults;
		propList = [];
		var p:String;
		var ct = new ColorTransform();
		for ( p in value ) {
			if (p == "brightness" || p == "tintColor" || p == "tintMultiplier" || p == "burn") continue;
			propList.push(p);
			ct[p] = value[p];
		}
		value = ct;
		current = target.transform.colorTransform;		
		super.init();
	}

	function update ($position) {
		super.update($position);
		target.transform.colorTransform = current;
	}
}
