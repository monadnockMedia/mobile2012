﻿package com.mobile.signalFlags {	import com.greensock.TweenLite;	import flash.display.MovieClip;			public class flipper extends MovieClip {		var aR:Array = [-90,0,90];		var aZ:Array= [0,-30,0];		var i:Number=0;				public function flipper(iState:Number=3) {			// constructor code			addEventListener(Event.ADDED_TO_STAGE, init);		}				private function init(e:Event):void		{			this.rotationY = aR[i];			this.rotationY = aR[i];		}	}	}