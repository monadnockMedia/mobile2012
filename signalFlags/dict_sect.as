﻿package com.mobile.signalFlags {	//import caurina.transitions.*;	import com.greensock.*;	import com.greensock.easing.*;	import flash.display.Sprite;	import flash.events.*;	public class dict_sect extends Sprite {		private var _cfg:XML = new XML;		private var tranIn,tranOut:String = "linear";		private var iX,iY,iroZ,tX,tY,troZ,timeIn,timeOut:Number=0;				public function dict_sect() {			// constructor code			this.cacheAsBitmap = true;			visible = false;		}						/*<pageLeft>			<offStage x="" y="" roZ="" />			<onStage x="" y="" roZ="" />		</pageLeft>		*/		public function set cfg(val:XML):void		{				_cfg = val;								iX = xmlToNumber(_cfg.offStage.@X);				iY = xmlToNumber(_cfg.offStage.@Y);				iroZ = xmlToNumber(_cfg.offStage.@roZ);				tX = xmlToNumber(_cfg.onStage.@X);				tY = xmlToNumber(_cfg.onStage.@Y);				troZ = xmlToNumber(_cfg.onStage.@roZ);								tranIn = _cfg.tranIn.toString();				tranOut = _cfg.tranOut.toString();				timeOut = xmlToNumber(_cfg.tranOut.@time);				timeIn = xmlToNumber(_cfg.tranIn.@time);					x=iX;				y=iY;				rotation = iroZ;				visible = true;		}				private function xmlToNumber(xIn:XMLList):Number		{			return Number(xIn.toString());		}				public function swingOn():void		{						//Tweener.addTween(this, {x:tX,y:tY,rotation:troZ,transition:tranIn,time:timeIn,onComplete:tweenComplete,onCompleteParams: ["onStage"]})			TweenLite.to(this, timeIn, {x:tX,y:tY,rotation:troZ,ease:tranIn,onComplete:tweenComplete, onCompleteParams: ["onStage"]});		}				public function swingOff():void		{			TweenLite.to(this, timeOut,{x:iX,y:iY,rotation:iroZ,ease:tranOut,onComplete:tweenComplete,onCompleteParams: ["offStage"]}); 			//Tweener.addTween(this, {x:iX,y:iY,rotation:iroZ,transition:tranOut,time:timeOut,onComplete:tweenComplete,onCompleteParams: ["offStage"]})		}				private function tweenComplete(e:String):void		{			dispatchEvent(new Event(e));		}	}	}