﻿package com.mobile.GulfLinks {		import wck.*;	import flash.events.*;	import Box2DAS.Common.*;	import flash.utils.*;	import flash.geom.*;		import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import cmodule.Box2D.*;	import wck.*;	import misc.*;	import flash.utils.*;	import flash.events.*;	import flash.display.*;	import flash.text.*;	import flash.geom.*;	import flash.ui.*;	import gravity.Gravity;	import flash.utils.Dictionary;		public class thisWorld extends wck.World {		var numItems:Number = 6;		var theItems:Array = new Array();		var lastI:Number;		var focusI:delItem;		//var allItems:Dictionary = new Dictionary();		var allItems:Dictionary = new Dictionary();		var lastStageItems:Dictionary = new Dictionary();		var stageItems:Dictionary = new Dictionary();		var wUtil:worldUtil = new worldUtil();				public function thisWorld() {						// constructor code			//thisI = theItems[lastI-1];			//thisI.myFocus();								}	//Setters		public function set all(val:Dictionary):void		{			allItems = val;		}				public function set focusTag(val:String):void		{				//(this.grav.gravX == 0) ? this.grav.gravX = 10 : null;			//(focusI == null) ? null : focusI.itemBlur();			focusI = allItems[val];			//focusI.itemFocus();					}						//accepts array of all tags that should be visible		public function itemUpdate(tags:Array):void		{			//find tags that need to be added			for each ( var _t:String in tags)			{				//reference a delItem based on current tag				var currentStageItem:delItem = allItems[_t];				//add it to the stageItems				stageItems[_t] = currentStageItem;								//If it does not exist on stage, add it.				//(lastStageItems == null) ? null : var isOn:Boolean = (lastStageItems[_t] == undefined) ? false: true;				(!lastStageItems[_t]) ? addItem(currentStageItem): null;			}									//find tags that need removing			for each ( var _dI:delItem in lastStageItems )			{				//tag of current stage item				var _tag:String = _dI.tag;				// if the delItem doesn't exist in the new stageItem list, remove it.				(!stageItems[_tag]) ? removeItem(_dI) : null;			}						//update lastStageItems, for next time.			lastStageItems = stageItems;		}						private function removeItem(_d:delItem):void		{			removeChild(_d);		}				private function addItem(_d:delItem):void		{			var _x:Number = Math.random()*this.width;			var _y:Number = Math.random()*this.height;			addChild(_d);			(_d == focusI) ? _d.itemFocus() : _d.itemBlur();			wUtil.randomShove(_d);		}			/*private function mouseDownHandler(e:MouseEvent):void			{				var tI:delItem = e.currentTarget as delItem;				(e.altKey) ? switchFocus(tI) : null;			}					private function rightClickHandler(e:MouseEvent):void			{				wUtil.repel(e.currentTarget as delItem, new V2(0,0));			}*/					/*private function switchFocus(tI:delItem):void		{			this.mouseEnabled = false;			var _origin:V2 = new V2(tI.x, tI.y);						for each (var i:delItem in theItems){				(i.isFocus) ? i.itemBlur() : null;				//repel(i,_origin);			}			tI.itemFocus();		}*/									}	}