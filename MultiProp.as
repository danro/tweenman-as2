
import com.tweenman.BaseProp;

class com.tweenman.MultiProp extends BaseProp {

	var props:Object;
	var propList:Array;
	var current:Object;
	var defaults:Object;
	var classes:Object;

	function construct () {
		props = {};
	}

	function init () {
		var propCount:Number = propList.length;
		var valueIsArray:Boolean = value instanceof Array;
		var valueIsObject:Boolean = typeof value == "object" && !valueIsArray;
		var i:Number, prop:BaseProp, propID:String, propClass:Function;
		for ( i = 0; i < propCount; i++ ) {
			propID = propList[i];
			propClass = classes[propID] == null ? BaseProp : classes[propID];
			prop = new propClass();
			props[propID] = prop;
			if (valueIsArray) {
				prop.value = value[i];
			} else if ( valueIsObject ) {
				if (value[propID] == null) value[propID] = defaults[propID];
				prop.value = value[propID];
			} else {
				prop.value = value;
			}
			prop.id = propID;
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