
import com.tweenman.BaseProp;

class com.tweenman.VisibleProp extends BaseProp {

	function init () {
		id = "_alpha";		
		if (value === true) value = 100;
		if (value === false) value = 0;
		super.init();
	}

	function update ($position) {
		super.update($position);
		if (target._alpha < 0.01) {
			if (target._visible) target._visible = false;
		} else if (target._alpha > 0.01) {
			if (!target._visible) target._visible = true;
		}
	}
}