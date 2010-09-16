
import flash.filters.DisplacementMapFilter;
import com.tweenman.BaseFilterProp;
import com.tweenman.HexColorProp;

class com.tweenman.DisplaceProp extends BaseFilterProp {

	function init () {
		filterClass = DisplacementMapFilter;
		defaults = { scaleX: 0.0, scaleY: 0.0, color: 0, alpha: 0.0 };
		classes = { color: HexColorProp };
		initializers = { mapBitmap: "", mapPoint: "", componentX: "", componentY: "", mode: "" };
		super.init();
	}
}