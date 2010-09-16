
import flash.display.BitmapData;
import flash.filters.BitmapFilter;
import com.tweenman.MultiProp;

class com.tweenman.BaseFilterProp extends MultiProp {

	var filterClass:Function;
	var initializers:Object;

	function init () {
		var valid:Boolean = typeof(target) == "movieclip" || target instanceof Button || target instanceof TextField;
		if (!valid) return tween.typeError(id, "MovieClip, Button, TextField");
		if (value == null) value = defaults;
		propList = [];
		var p:String;
		var initList:Object = {};
		for ( p in value ) {
			if (defaults[p] != null) {
				propList.push(p);
			} else if (initializers[p] != null) {
				initList[p] = value[p];
				delete value[p];
			}
		}
		var filters:Array = target.filters;
		var filterCount:Number = filters.length;
		var filterFound:Boolean = false;
		var i:Number;
		for ( i = 0; i < filterCount; i++ ) {
			if ( filters[i] instanceof filterClass ) {
				current = filters[i];
				filterFound = true;
			}
		}
		if (!filterFound) {
			current = new filterClass();
			for ( p in defaults ) {
				current[p] = defaults[p];
			}
		}
		for ( p in initList ) {
			current[p] = initList[p];
		}
		var valueIsArray:Boolean = value instanceof Array;
		var valueIsObject:Boolean = typeof value == "object" && !valueIsArray;
		if (!valueIsObject) return tween.valueError(id);
		super.init();
	}

	function update ($position) {
		super.update($position);
		var filters:Array = target.filters;
		var filterCount:Number = filters.length;
		var i:Number;
		for ( i = 0; i < filterCount; i++ ) {
			if ( filters[i] instanceof filterClass ) {
				filters[i] = current;
				target.filters = filters;
				return;
			}
		}
		if (filters == null) filters = [];
		filters.push(current);
		target.filters = filters;
	}
}