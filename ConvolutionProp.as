
import flash.filters.ConvolutionFilter;
import com.tweenman.BaseFilterProp;
import com.tweenman.HexColorProp;

class com.tweenman.ConvolutionProp extends BaseFilterProp {

	function init () {
		filterClass = ConvolutionFilter;
		defaults = { divisor: 1.0, bias: 0.0, color: 0, alpha: 0.0 };
		classes = { color: HexColorProp };
		initializers = { matrix: "", matrixX: "", matrixY: "", preserveAlpha: "", clamp: "" };
		super.init();
	}
}