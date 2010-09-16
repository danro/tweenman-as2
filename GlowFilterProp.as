
import flash.filters.GlowFilter;
import com.tweenman.BaseFilterProp;
import com.tweenman.HexColorProp;

class com.tweenman.GlowFilterProp extends BaseFilterProp {

	function init () {
		filterClass = GlowFilter;
		defaults = { alpha: 1, blurX: 0.0, blurY: 0.0, strength: 0, color: 0 };
		classes = { color: HexColorProp };
		initializers = { quality: "", inner: "", knockout: "" };
		super.init();
	}
}