﻿package com.mobile.signalFlags {		public class textFlag extends flagStatic {						public function textFlag() {			// constructor code		}				public override function set letter(val:String):void		{						switch (val)			{				case "0":					numText("0", 1)					break;				case "1":					numText("1", 2)					break;				case "2":					numText("2", 3)					break;				case "3":					numText("3", 4)					break;				case "4":					numText("4", 5)					break;				case "5":					numText("5", 6)					break;				case "6":					numText("6", 7)					break;				case "7":					numText("7", 8)					break;				case "8":					numText("8", 9)					break;				case "9":					numText("9", 10)					break;				case "!":					altText("First Repeater", "!");					break;				case "@":					altText("Second Repeater", "@");					break;				case "#":					altText("Third Repeater", "#");					break;				case "$":					altText("Fourth Repeater", "$");					break;				default:					var flVal:String;					this.field.text = val;					this.alt_field.text = "";					flVal = val.toLowerCase();					this.miniFlag_mc.gotoAndStop(flVal);			}											}				public function numText(str:String, frame:Number):void		{			this.miniFlag_mc.gotoAndStop(frame);			this.alt_field.text = "";			this.field.text= str;		}				public function altText(str:String, frame:String):void		{			this.field.text = "";			this.alt_field.text = str;			this.miniFlag_mc.gotoAndStop(frame);		}			}	}