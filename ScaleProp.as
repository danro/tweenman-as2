
import com.tweenman.MultiProp;

class com.tweenman.ScaleProp extends MultiProp {

	function init () {
		propList = ["_xscale", "_yscale"];
		current = target;
		super.init();
	}
}