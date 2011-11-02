﻿package com.mobile.signalFlags {		import flash.display.MovieClip;	import fl.transitions.*;	import fl.transitions.easing.*;	import fl.motion.easing.*;	import flash.filters.*;	import caurina.transitions.*;	import flash.events.KeyboardEvent ;	import flash.events.Event;	import com.nestor.elements.soundLoop;	import flash.display.Bitmap;	import flash.display.BitmapData;	public class ship extends MovieClip {		var totalFlags:int=10;		var spacing:Number = 10;		var flag_meta:MovieClip;		var flagArray:Array = [];		var poleArray:Array = new Array();		var n:Number=0;		var poleI:Number=0;		var mesArray:Array = new Array();		var flagCheck:Boolean = false;		var sea:soundLoop;		var creak:soundLoop;		//add To config???		var seaSound:String="snd/sea.mp3"		var seaV:Number=0.3;				var creakSound:String="snd/creak.mp3"		var creakV:Number=0.3;				//add to config		var doubleErrorH:String = "Sorry...";		var doubleErrorB:String = "You've already used this flag.  You only have one set of flags to compose your message, you must use REPEATER flags to repeat a character.  For more information, please push the button marked 'Explore the Flags.'";				var wallpaper:Bitmap;				public function ship() {			// constructor code						this.debugField.visible=true;						sea = new soundLoop(seaSound,seaV);			sea.addEventListener(Event.COMPLETE,sndReady);						creak = new soundLoop(creakSound,creakV);			creak.addEventListener(Event.COMPLETE,sndReady);						addEventListener(Event.ADDED_TO_STAGE, init);		}				private function sndReady(e:Event):void		{			e.target.startLoop();		}						private function init(e:Event):void		{			poleArray = [this.pole1,this.pole2];			poleArray[poleI].addEventListener("poleFull", nextPole);			paper_mc.alpha=0;		}				public function addFlag(e:KeyboardEvent):void{			trace("::SHIP:: checkingKey");			//stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);							var keyNum = e.charCode;			switch (keyNum) {				case 13:					messageComplete(e)					break;				case 27:					exit();					break;				case 8:					backspace();					break;				case 127:					backspace();					break;				default:										(keyNum >= 48 && keyNum <= 57) 						? parseFlagKey(String.fromCharCode(keyNum)) 						: (keyNum >=97 && keyNum <= 124) 							? parseFlagKey(String.fromCharCode(keyNum)) 							:badKey(e);								} 					}				function parseFlagKey(_keyPressed):void		{			trace("::SHIP:: does "+_keyPressed+"=="+poleArray[poleI].word+"??");			//for each (var str:String in mesArray) {  // old check for multiple poles			for each (var str:String in poleArray[poleI].word) {  // old check for multiple poles				flagCheck = (str == _keyPressed) ? true : false;												trace("::SHIP:: "+_keyPressed+" == "+str+"?? :: "+flagCheck);				if (flagCheck == true)  break ;			} 						if (flagCheck == false){				trace("::SHIP:: NO, pushing array.");				//mesArray.push(_keyPressed);								poleArray[poleI].addFlag(_keyPressed);				this.debugField.text="mesArray :: "+poleArray[0].word+"::"+poleArray[1].word;			}			else if (flagCheck == true){				trace("::SHIP:: YES, redundancy found.");				paperMessage(doubleErrorH,doubleErrorB);							}		}		private function badKey(e:Event):void		{			trace("::SHIP:: BAD KEY:"+e);			resetHandler();		}		private function resetHandler():void{			dispatchEvent(new Event("resetKeyboard", true));		}				private function nextPole(e:Event):void		{			poleArray[poleI].removeEventListener("poleFull", nextPole);			poleI++;			poleArray[poleI].addEventListener("poleFull", messageComplete);			dispatchEvent(new Event("resetKeyboard",true));		}		private function messageComplete(e:Event):void		{			dispatchEvent(new Event("messageComplete"));		}				function exit():void		{			dispatchEvent(new Event("exit"));			paperMessage("Exiting...","Guess you were bored.",500);		}				function backspace():void		{			poleArray[poleI].removeFlag();			this.debugField.text="mesArray :: "+poleArray[0].word+"::"+poleArray[1].word;			//dispatchEvent(new Event("backspace"));			//paperMessage("Backspace","Not Implemented Yet",500);		}				public function paperMessage(head:String,body:String,time:Number=2000, exit:Boolean = true):paper		{			var thisPaper:paper = new paper(head,body,time,exit);			addChild(thisPaper);			thisPaper.addEventListener("paperOff", paperOffHandler);			return thisPaper;		}				private function paperOffHandler(p:Event):void		{			var pt:paper = p.target as paper			pt.removeEventListener("paperOff", paperOffHandler);			removeChild(pt);			pt=null;			resetHandler();		}				public function snap():BitmapData		{									var bmd:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);			bmd.draw(this);			wallpaper = new Bitmap(bmd);			addChild(wallpaper);			//anim.alpha=1;			return bmd;		}									}	}//OG CODE/*																	*/