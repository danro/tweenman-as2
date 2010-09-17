`package com.tweenman`

TweenMan AS2 ActionScript tweening library
==========================================

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

See Also
--------

* [Examples](http://github.com/danro/tweenman-examples)
* [TweenMan AS3](http://github.com/danro/tweenman-as3)
