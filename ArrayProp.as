
import com.tweenman.BaseProp;

class com.tweenman.ArrayProp extends BaseProp {

	var props:Object;
	var current:Object;

	function construct () {
		props = {};
	}

	function init () {
		if (current == null) {
			if (target instanceof Array) {
				current = target;
			} else if (target[id] instanceof Array) {
				current = target[id];
			}
		}
		var valueIsArray:Boolean = value instanceof Array;
		if (!valueIsArray) return tween.valueError(id);
		var count:Number = current.length;
		var i:Number, prop:BaseProp;
		for ( i = 0; i < count; i++ ) {
			prop = new BaseProp();
			props[ String(i) ] = prop;
			prop.id = i;
			prop.value = value[i];
			prop.target = current;
			prop.init();
		}
	}

	function update ($position) {
		var p:String;
		for (p in props) {
			props[p].update($position);
		}
	}
}
