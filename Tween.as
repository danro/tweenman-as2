
import com.tweenman.TweenMan;
import com.tweenman.BaseProp;
import com.tweenman.ArrayProp;
import com.tweenman.InternalProps;
import com.tweenman.VirtualProps;

class com.tweenman.Tween {

	var id:String;
	var targetID:String;
	var target:Object;
	var duration:Number;
	var delay:Number;
	var vars:Object;
	var ease:Function;
	var props:Object;
	var children:Number;

	var activated:Boolean;
	var startTime:Number;
	var initTime:Number;
	var timeMethod:Function;
	static var ZERO:Number = 0.001;

	public function Tween ($target:Object, $vars:Object, $id:String, $targetID:String) {
		target = $target;
		vars = $vars;
		id = $id;
		targetID = $targetID;
		children = 0;
		if (!isNaN(vars.time)) vars.duration = vars.time;
		duration =  vars.duration;
		delay = vars.delay;
		if (isNaN(delay) || delay < 0) delay = 0;
		if (!isNaN(vars.frames)) {
			timeMethod = TweenMan.getFrames;
			duration = int(vars.frames);
			delay = int(delay);
		} else {
			timeMethod = getGlobalTimer;
		}		
		if (isNaN(duration) || duration <= 0) duration = ZERO;
		ease = typeof(vars.ease) == "function" ? vars.ease : TweenMan.defaultEase;
		if (vars.easeParams != null) {
			vars.proxiedEase = ease;
			ease = easeProxy;
		}
		props = {};
		initTime = timeMethod();
		activated = false;
		initProps();
		if (duration == ZERO && delay == 0) {
			startTime = 0;
			render(1, 1);
		} else {
			TweenMan.enableRender();
		}
	}

	function render ($t:Number, $f:Number) {
		var elapsed:Number;
		if (timeMethod == getGlobalTimer) {
			elapsed = ($t - startTime) / 1000;
		} else {
			elapsed = $f - startTime;
		}
		if (elapsed > duration) elapsed = duration;
		var position:Number = ease(elapsed, 0, 1, duration);
		var p:String;
		for (p in props) {
			props[p].update(position);
		}
		if (vars.onUpdate != null) runCallback(vars.onUpdate, vars.onUpdateParams);
		if (elapsed == duration) {
			complete();
		}
	}

	function get active():Boolean {
		if (activated) {
			return true;
		} else {
			if (timeMethod == getGlobalTimer) {
				if ((timeMethod() - initTime) / 1000 > delay) {
					activated = true;
					startTime = initTime + (delay * 1000);
					if (vars.onStart != null) runCallback(vars.onStart, vars.onStartParams);
					if (duration == ZERO) startTime -= 1;
					return true;
				}
			} else {
				if (timeMethod() - initTime > delay) {
					activated = true;
					startTime = initTime + delay;
					if (vars.onStart != null) runCallback(vars.onStart, vars.onStartParams);
					if (duration == ZERO) startTime -= 1;
					return true;
				}
			}
		}
		return false;
	}

	function removeProp ($p:String):Boolean {
		if (props[$p] == null) {
			return false;
		} else {
			--children;
			delete props[$p];
			return true;
		}
	}

	function typeError ($p, $type) {
		trace("TweenMan says: target must be type [" + $type + "] to use [" + $p + "]");
		removeProp($p);
	}

	function valueError ($p) {
		trace("TweenMan says: unexpected value given for " + target + "[" + $p + "]");
		removeProp($p);
	}

	private function complete () {
		var onComplete = vars.onComplete;
		var onCompleteParams = vars.onCompleteParams;
		TweenMan.kill(this);
		if (onComplete != null) runCallback(onComplete, onCompleteParams);
	}

	private function initProps() {
		var prop:BaseProp;
		var p:String;
		for (p in vars) {
			if ( InternalProps[p] != null ) {
				continue;
			} else {
				var propClass:Function;
				if ( VirtualProps[p] != null ) {
					propClass = VirtualProps[p];
				} else if ( p == "array" && target instanceof Array ) {
					propClass = ArrayProp;
				} else if ( target[p] != null ) {
					propClass = BaseProp;
				}
				if ( propClass != null ) {
					++children;
					prop = new propClass();
					props[p] = prop;
					prop.id = p;
					prop.tween = this;
					prop.target = target;
					prop.value = vars[p];
					prop.init();
				} else {
					trace("TweenMan says: target [" + target + "] does not contain property [" + p + "]");
				}
			}
		}
	}

	private function easeProxy ():Number {
		return vars.proxiedEase.apply(null, arguments.concat(vars.easeParams));
	}
	
	private function runCallback ($callback:Object, $params:Object) {
		if ($callback instanceof Array) {
			$callback[1].apply($callback[0], $params);
		} else {
			$callback.apply(null, $params);
		}
	}
	
	private static function getGlobalTimer ():Number {
		return getTimer();
	}
}