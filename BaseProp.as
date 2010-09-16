
import com.tweenman.Tween;

class com.tweenman.BaseProp {

	var id:Object;
	var tween:Tween;
	var start:Number;
	var change:Number;
	var target:Object;
	var value:Object;

	function BaseProp () {
		construct();
	}

	function construct () {}

	function init () {
		start = target[id];
		change = typeof(value) == "number" ? value - start : Number(value);
	}

	function update ($position) {
		var result:Number = start + ($position * change);
		if (target[id] != result) target[id] = result;
	}
}