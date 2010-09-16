
import com.tweenman.MultiProp;

class com.tweenman.HexColorProp extends MultiProp {

	function init () {
		propList = ["r", "g", "b"];		
		current = hexToRgb( target[id] );
		value = hexToRgb( value );
		super.init();
	}

	function update ($position) {
		super.update($position);
		target[id] = (current.r << 16 | current.g << 8 | current.b);
	}
	
	function hexToRgb ($hex):Object {
		if ($hex == null) $hex = 0x000000;
		return { r: ($hex >> 16), g: ($hex >> 8) & 0xff, b: $hex & 0xff };
	}
}