
import flash.filters.BlurFilter;
import com.tweenman.BaseFilterProp;

class com.tweenman.BlurFilterProp extends BaseFilterProp {

	function init () {
		filterClass = BlurFilter;
		defaults = { blurX: 0.0, blurY: 0.0 };
		initializers = { quality: "" };
		super.init();
	}
}