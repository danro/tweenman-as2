/*
	Version: 1.5 AS2
	---------------------------------------------------------------------------------
	TweenMan is a complicated man, and no one understands him but his woman...
	Initially influenced by Jack Doyle's TweenLite engine, TweenMan is now his own man 
	attempting to provide extended tweening functionality while remaining fit and slim.
	
	Weighing in at approximately 10k compiled, TweenMan does a few things you probably 
	haven't seen other engines do. He can tween the scrollRect property of clips and 
	tween just about every filter's properties including the color of glows, bevels,
	etc., and he can accomplish this by using time-based or frame-based animation.
	
	For updates and examples, visit: http://www.tweenman.com

	Author: Dan Rogers - dan@danro.net

	Special Thanks:	Jack Doyle for sharing TweenLite (greensock.com)
					Mario Klingemann for sharing ColorMatrix (quasimondo.com)
					Robert Penner for his AS2 easing functions (robertpenner.com)

	Basic Usage
	---------------------------------------------------------------------------------
	import com.tweenman.TweenMan;
	import com.tweenman.easing.*;

	// time-based _alpha tween
	TweenMan.addTween(target, { time: 1, _alpha: 0 });

	// frame-based scrollRect tween
	TweenMan.addTween(target, { frames: 50, rectangle: [0,0,100,100], ease: Back.easeOut });

	// time-based ColorMatrixFilter tween
	TweenMan.addTween(target, { time: 2, colormatrix: { saturation: 0, contrast: 2 } });
	
	// tween an array
	var myArray:Array = [1, 4, 5, 6];
	TweenMan.addTween(myArray, { time: 1, array: [0, 3, 4, 4] });

	// remove tweens by property
	TweenMan.removeTweens(target, "_alpha", "rectangle", "color");
	
	// see if a tween is active
	TweenMan.isTweening(target, "color");


	Tween Properties
	---------------------------------------------------------------------------------
	time					time or duration of tween in seconds
	duration				eqivalent to time, duration in seconds
	frames					frame-based duration, overrides time/duration if set
	ease					easing function, default is Quartic.easeOut
	delay					delay before start, in seconds or frames depending on setting
	onComplete				callback function gets called when tween finishes
	onCompleteParams		params for onComplete function
	onUpdate				callback function gets called when tween updates
	onUpdateParams			params for onUpdate function
	onStart					callback function gets called when tween starts
	onStartParams			params for onStart function
	easeParams				params for ease function, mostly Back and Elastic
	array					if the target is an array, this property sets the end values


	Virtual Properties  
	  { prop: value } indicates tweenable sub-properties and default values
	---------------------------------------------------------------------------------
	visible			number or boolean		same as _alpha but toggles visibility
	frame			number					frame number of a MovieClip
	scale			number					_xscale and _yscale properties combined
	color			object					transform a target using ColorTransform
	  { redMultiplier: 1.0, greenMultiplier: 1.0, blueMultiplier: 1.0, alphaMultiplier: 1.0, 
		redOffset: 0, greenOffset: 0, blueOffset: 0, alphaOffset: 0, brightness: 0,
		tintColor: 0x000000, tintMultiplier: 0, burn: 0 }
	
	rectangle		[0,0,100,100]			scrollRect property of a DisplayObject
	volume			number					volume of a MovieClip sound
	pan				number					pan of a MovieClip sound
	
	colormatrix		object					ColorMatrixFilter
	  { brightness: 0, contrast: 0, saturation: 1, hue: 0, colorize: 0x000000, 
		colorizeAmount: 0, blend: false } // set blend for additive blending
	
	bevel			object					BevelFilter
	  { distance: 4.0,  angle: 45, highlightColor: 0xFFFFFF, highlightAlpha: 1.0, 
		 shadowColor: 0x000000, shadowAlpha: 1.0, blurX: 4.0, blurY: 4.0, strength: 0 }
	
	blur			object					BlurFilter
	  { blurX: 0.0, blurY: 0.0 }
	
	convolution		object					ConvolutionFilter
	  { divisor: 1.0, bias: 0.0, color: 0, alpha: 0.0 }
	
	displace		object					DisplacementMapFilter
	  { scaleX: 0.0, scaleY: 0.0, color: 0, alpha: 0.0 }
	
	dropshadow		object					DropShadowFilter
	  { distance: 0.0, angle: 45, color: 0, alpha: 1.0, blurX: 0.0, blurY: 0.0, strength: 0 }
	
	glow			object					GlowFilter
	  { alpha: 1, blurX: 0.0, blurY: 0.0, strength: 0, color: 0 }


	TweenMan is Licensed under the MIT License
	---------------------------------------------------------------------------------
	Copyright (c) 2008 Dan Rogers

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.
*/

import com.tweenman.Tween;
import com.tweenman.InternalProps;
import com.tweenman.ConflictMap;
import com.tweenman.easing.Quartic;

class com.tweenman.TweenMan {

	public static var version:String = "1.5 AS2";
	public static var defaultEase:Function = Quartic.easeOut;
	
	private static var listenerDepth:Number = 7777;
	private static var listenerName:String = "$tweenManListener";
	private static var renderEnabled:Boolean;
	private static var cleanupTimer:Number;
	private static var tweenDict:Object;
	private static var frameCount:Number;
	private static var tweenCount:Number;
	private static var targetCount:Number;
	
	public function TweenMan () {
		if (_root[listenerName] != null) return;
		_root[listenerName] = _root.createEmptyMovieClip(listenerName, listenerDepth);
		_root[listenerName].onEnterFrame = TweenMan.enterFrameUpdate;
		tweenDict = {};
		resetCounts();
	}
	
	public static function addTween ($target:Object, $vars:Object) {
		if (_root[listenerName] == null) new TweenMan();

		if ($target == null) { trace("TweenMan says: target is null, vars [" + $vars + "]"); return; }

		var targetID:String = getTargetID($target);

		if (tweenDict[targetID] == null ) {
			tweenDict[targetID] = {};
		} else {
			var removeParams:Array = [targetID];
			for (var p:String in $vars) {
				if ( InternalProps[p] != null ) continue;
				removeParams.push(p);
				if ( ConflictMap[p] != null ) {
					removeParams = removeParams.concat(ConflictMap[p]);
				}
			}
			removeTweens.apply(null, removeParams);
		}
		if (tweenDict[targetID] == null) tweenDict[targetID] = {};
		var tweenID:String = "t" + String(++tweenCount);
		tweenDict[targetID][tweenID] = new Tween($target, $vars, tweenID, targetID);
	}
	
	public static function removeTweens ($target:Object) {
		var targetID:String = typeof($target) == "string" ? String($target) : getTargetID($target);
		if ($target == null || tweenDict[targetID] == null) return;
		arguments.shift();
		if (arguments.length == 0) {
			delete tweenDict[targetID];
		} else {
			var i:Number, p:String, tweenID:String, tween:Tween, removed:Boolean;
			var count:Number = arguments.length;
			for (i = 0; i<count; i++) {
				p = arguments[i];
				for (tweenID in tweenDict[targetID]) {
					tween = tweenDict[targetID][tweenID];
					removed = tween.removeProp(p);
					if (removed && tween.children == 0) kill(tween);
				}
			}
		}
	}
	
	public static function removeAll () {
		tweenDict = {};
		killGarbage();
	}
	
	public static function isTweening ($target:Object, $prop:String):Boolean {
		killGarbage();
		var targetID:String = getTargetID($target);
		if (tweenDict[targetID] == null) return false;
		if ($prop == null) return true;
		var tweenID:String, tween:Tween;
		for (tweenID in tweenDict[targetID]) {
			tween = tweenDict[targetID][tweenID];
			if (tween.props[$prop] != null) return true;
		}
		return false;
	}
	
	public static function killGarbage () {
		var count:Number = 0;
		var found:Boolean;
		var targID:String, tweenID:String;
		for (targID in tweenDict) {
			found = false;
			for (tweenID in tweenDict[targID]) {
				found = true;
				break;
			}
			if (!found) {
				delete tweenDict[targID];
			} else {
				++count;
			}
		}
		if (count == 0) {
			disableRender();
		}
	}
	
	public static function getTargetID ($target:Object):String {
		if (typeof($target) == "movieclip") return String($target);
		var targID:String, tweenID:String, tween:Tween;
		for (targID in tweenDict) {
			for (tweenID in tweenDict[targID]) {
				tween = tweenDict[targID][tweenID];
				if (tween.target === $target) return targID;
			}
		}
		++targetCount;
		return "targetID:"+targetCount;
	}
	
	static function kill ($tween:Tween) {
		var targetID:String = $tween.targetID;
		var tweenID:String = $tween.id;
		if (tweenDict[targetID] == null || tweenDict[targetID][tweenID] == null) return;
		delete tweenDict[targetID][tweenID];
	}
	
	static function getFrames ():Number {
		return frameCount;
	}
	
	static function enableRender () {
		if (!renderEnabled) {
			clearInterval(cleanupTimer);
			cleanupTimer = setInterval(TweenMan.killGarbage, 2000);
			renderEnabled = true;
		}
	}

	static function disableRender () {
		clearInterval(cleanupTimer);
		resetCounts();
		renderEnabled = false;
	}
	
	private static function enterFrameUpdate () {
		if (!renderEnabled) return;
		++frameCount;
		render();
	}
	
	private static function render () {
		var t:Number = getTimer();
		var f:Number = frameCount;
		var targID:String, tweenID:String, tween:Tween;
		for (targID in tweenDict) {
			for (tweenID in tweenDict[targID]) {
				tween = tweenDict[targID][tweenID];
				if (tween.active) tween.render(t,f);
			}
		}
	}
	
	private static function resetCounts () {
		frameCount = 0;
		tweenCount = 0;
		targetCount = 0;
	}
}