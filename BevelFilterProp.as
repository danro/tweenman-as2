
import flash.filters.BevelFilter;
import com.tweenman.BaseFilterProp;
import com.tweenman.HexColorProp;

class com.tweenman.BevelFilterProp extends BaseFilterProp {

	function init () {
		filterClass = BevelFilter;
		defaults = { distance: 4.0,  angle: 45, highlightColor: 0xFFFFFF, highlightAlpha: 1.0, shadowColor: 0x000000, shadowAlpha: 1.0, blurX: 4.0, blurY: 4.0, strength: 0  };
		classes = { highlightColor: HexColorProp, shadowColor: HexColorProp };
		initializers = { quality: "", type: "", knockout: "" };
		super.init();
	}
}