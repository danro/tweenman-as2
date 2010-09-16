
import flash.filters.DropShadowFilter;
import com.tweenman.BaseFilterProp;
import com.tweenman.HexColorProp;

class com.tweenman.DropShadowProp extends BaseFilterProp {

	function init () {
		filterClass = DropShadowFilter;
		defaults = { distance: 0.0, angle: 45, color: 0, alpha: 1.0, blurX: 0.0, blurY: 0.0, strength: 0 };
		classes = { color: HexColorProp };
		initializers = { quality: "", inner: "", knockout: "", hideObject: "" };
		super.init();
	}
}