﻿package com.mobile.signalFlags {		import flash.display.MovieClip;	import caurina.transitions.*;	import flash.events.Event;	import com.nestor.elements.soundLoop;	public class pole extends MovieClip {		var word:Array = new Array();		var flags:Array = new Array(0);		var letter:String;		var maxFlags:Number = 5;		var _initY:Number;		var lastFlag:Boolean=false;		var squeak:soundLoop;		var sqURL:String="snd/squeak.mp3";		//ad to cfg		var sqV:Number = 0.2;						public function pole() {			// constructor code			squeak = new soundLoop(sqURL,sqV);			this.addEventListener(Event.ADDED_TO_STAGE, init);		}				private function init(e:Event):void		{			_initY = this.height;					}				public function addFlag(l:String):void		{			var largo:Number = word.length;			trace("::POLE:: Attempting to add Flag :: "+l+" Array Length before adding = "+largo);			letter = l;			newFlag();		}				private function newFlag():void		{			//fid is one-based			var fid = word.push(letter);			// test for last flag			lastFlag = (fid == maxFlags) ? true : false;						trace("::POLE:: Flag Checked, making new Flag, lastFlag is"+lastFlag);			var thisFlag:flagWave = new flagWave(letter);						//n is zero-based			var n:Number = flags.push(thisFlag)-1;			thisFlag.width *= 0.17;			thisFlag.height *= 0.17;;						thisFlag.initY = _initY;			thisFlag.targetY= thisFlag.height*(n%5)			this.addChild(thisFlag);			squeak.randomOffset();			squeak.startLoop();					(lastFlag) ? poleFull() : thisFlag.addEventListener("flagUp", flagUp);						//flag_meta.flag_mc.gotoAndStop(keyPressed);						/*			Tweener.addTween(flagArray[n], {				y:flagArray[n].height*(n%5),				delay: 0,				transition:"easeInOutSine",				time:2,				onComplete:resetHandler});				*/					}							private function poleFull():void		{			trace("::POLE:: Pole is FULL!!");			dispatchEvent(new Event("poleFull"));		}		private function flagUp(e:Event):void		{			e.target.removeEventListener("flagUp", flagUp)			squeak.stopLoop();			dispatchEvent(new Event("resetKeyboard",true));		}				public function removeFlag():void		{					}	}}