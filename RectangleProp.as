
import flash.geom.Rectangle;
import com.tweenman.MultiProp;

class com.tweenman.RectangleProp extends MultiProp {

	function init () {
		var valid:Boolean = typeof(target) == "movieclip" || target instanceof Button || target instanceof TextField;
		if (!valid) return tween.typeError(id, "MovieClip, Button, TextField");
		propList = ["x", "y", "width", "height"];		
		if (!target.scrollRect) {
			var w:Number = Math.max(1, target._width * ( 100 / target._xscale ));
			var h:Number = Math.max(1, target._height * ( 100 / target._yscale ));			
			target.scrollRect = new Rectangle( 0, 0, w, h );
		}
		if (isNaN(value[2]) || value[2] < 1) value[2] = 1; // restrict size to 1px
		if (isNaN(value[3]) || value[3] < 1) value[3] = 1;
		current = target.scrollRect;
		super.init();
	}

	function update ($position) {
		super.update($position);
		target.scrollRect = current;
	}
}