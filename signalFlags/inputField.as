﻿package com.mobile.signalFlags {		import flash.display.MovieClip;	import flash.events.*;		public class inputField extends MovieClip {		private var _stringData:String="";		public function inputField() {			// constructor code			this.addEventListener(Event.ADDED_TO_STAGE, init);			this.hiGrad.visible=false;		}				public function set promptText(s:String):void		{			this.prompt.htmlText = s;					}								public function set kbActive(b:Boolean):void		{			(b) ? activate() : deactivate() ;		}				public function get data():String		{			return _stringData;		}				private function init(e:Event):void		{			clearField();		}				public function clearField():void		{			this.field.text = "";					}				private function activate():void		{			stage.focus =  this.field;			this.hiGrad.visible=true;			field.addEventListener( KeyboardEvent.KEY_UP, keyHandler);		}				private function deactivate():void		{			field.removeEventListener( KeyboardEvent.KEY_UP, keyHandler);			this.prompt.text = "";			this.hiGrad.visible=false;		}				private function keyHandler(k:KeyboardEvent):void		{			trace("::INPUTFIELD:: KEYHANDLER")			if ( k.charCode==13) doSubmit();		}				private function doSubmit():void		{			deactivate();			_stringData = this.field.text;			dispatchEvent(new Event("submit"));		}	}	}